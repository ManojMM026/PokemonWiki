import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/pokemon_card.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/viewmodel/type_poke_list_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/widget/appbar.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:provider/provider.dart';
import 'package:mypokedex/util/string_util.dart';

class TypesPokeList extends StatefulWidget {
  final TypeX type;

  TypesPokeList({this.type});

  @override
  _TypesPokeListState createState() => _TypesPokeListState();
}

class _TypesPokeListState extends State<TypesPokeList> {
  TypePokeListViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white70,
        systemNavigationBarColor: Colors.white70,
      ),
      child: Scaffold(
        appBar: PokedexAppBar(
          title: widget.type.name.capitalize(),
          onLeadingPressed: () => Navigator.pop(context),
        ).appBar(context: context),
        body: Container(
          color: Colors.white,
          child: BaseWidget<TypePokeListViewModel>(
            model: TypePokeListViewModel(repo: Provider.of(context)),
            onModelReady: (model) => _onModelReady(model),
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
                default:
                  break;
              }
              if (model.pokemonList == null || model.pokemonList.isEmpty) {
                return PlaceHolderView(
                  placeHolderText: Strings.placeHolder,
                );
              }
              return _buildGridView(MediaQuery.of(context).orientation, model);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGridView(Orientation orientation, TypePokeListViewModel model) {
    return GridView.builder(
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
    );
  }

  _onCardTapped(Pokemon pokemon) {
    Navigator.pushNamed(context, RoutePaths.POKEMON_DETAILS,
        arguments: pokemon);
  }

  _onModelReady(TypePokeListViewModel model) {
    _viewModel = model;
    _viewModel.getPokemonList(url: widget.type.url);
  }
}
