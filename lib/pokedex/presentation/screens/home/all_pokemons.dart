import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/pokemon_card.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_list_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:mypokedex/widget/pokemon_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class AllPokemons extends StatefulWidget {
  @override
  _AllPokemonsState createState() => _AllPokemonsState();
}

class _AllPokemonsState extends State<AllPokemons> {
  PokemonListViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      /*print('Scroll position :${_scrollController.position.}')*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /* floatingActionButton: FloatingActionButton(
          backgroundColor: blue,
          mini: true,
          onPressed: () {
            if (_scrollController != null) {
              _scrollController.animateTo(
                  _scrollController.position.minScrollExtent,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            }
          },
          child: Icon(Icons.arrow_circle_up_rounded),
        ),*/
        body: _buildView());
  }

  Widget _buildView() {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: BaseWidget<PokemonListViewModel>(
        model: PokemonListViewModel(repo: Provider.of(context)),
        onModelReady: (model) => _onPokeListModelReady(model),
        builder: (context, model, child) {
          switch (model.state) {
            case LoadingState.IDLE:
              break;
            case LoadingState.LOADING:
              break;
            case LoadingState.SUCCESS:
              break;
            case LoadingState.FAIL:
              return PlaceHolderView(
                placeHolderText: Strings.placeHolder,
              );
              break;
            default:
              break;
          }
          if (model.pokemonList == null || model.pokemonList.isEmpty) {
            return PlaceHolderView(
              placeHolderText: Strings.placeHolder,
            );
          }
          return _buildGridView(orientation, model);
        },
      ),
    );
  }

  Widget _buildGridView(Orientation orientation, PokemonListViewModel model) {
    return Scrollbar(
      isAlwaysShown: true,
      controller: _scrollController,
      child: PokemonPullToRefresh(
        onLoading: () => _onLoading(),
        onRefresh: () => _onRefresh(),
        controller: model.refreshController,
        child: GridView.builder(
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          itemCount: model.pokemonList != null ? model.pokemonList.length : 0,
          itemBuilder: (BuildContext context, int index) {
            Result pokemon = model.pokemonList[index];
            return PokemonCard(
              pokemon: pokemon,
              onCardTapped: _onCardTapped,
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait
                  ? AppConstants.portraitGridCount
                  : AppConstants.landScapeGridCount),
        ),
      ),
    );
  }

  _onCardTapped(Pokemon pokemon) {
    Navigator.pushNamed(context, RoutePaths.POKEMON_DETAILS,
        arguments: pokemon);
  }

  Future _onLoading() async {
    return _viewModel.getPokemonList(isForceRefresh: true);
  }

  Future _onRefresh() async {
    return _viewModel.getPokemonList(isForceRefresh: true);
  }

  void _onPokeListModelReady(PokemonListViewModel model) {
    _viewModel = model;
    model.getPokemonList();
  }
}
