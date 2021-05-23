import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/pokemon_card.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_fav_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/widget/appbar.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:provider/provider.dart';

class FavPokemons extends StatefulWidget {
  @override
  _FavPokemonsState createState() => _FavPokemonsState();
}

class _FavPokemonsState extends State<FavPokemons> {
  PokemonFavViewModel _viewModel;
  List<Result> favPokemons = [];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.white70,
        systemNavigationBarColor: Colors.white70,
      ),
      child: Scaffold(
          appBar: PokedexAppBar(
              title: Strings.tabFav,
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
              )).appBar(context: context),
          body: _buildView()),
    );
  }

  Widget _buildView() {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: BaseWidget<PokemonFavViewModel>(
        model: PokemonFavViewModel(repo: Provider.of(context)),
        onModelReady: (model) => _onPokeListModelReady(model),
        builder: (context, model, child) {
          if (favPokemons == null || favPokemons.isEmpty) {
            return PlaceHolderView(
              placeHolderText: Strings.placeHolder,
            );
          }
          return _buildGridView(orientation);
        },
      ),
    );
  }

  Widget _buildGridView(Orientation orientation) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: favPokemons.length,
      itemBuilder: (BuildContext context, int index) {
        Result pokemon = favPokemons[index];
        return Container(
            key: UniqueKey(),
            child: PokemonCard(pokemon: pokemon, onCardTapped: _onCardTapped));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait
              ? AppConstants.portraitGridCount
              : AppConstants.landScapeGridCount),
    );
  }

  _onCardTapped(Pokemon pokemon) {
    Navigator.pushNamed(context, RoutePaths.POKEMON_DETAILS, arguments: pokemon)
        .then((value) {
      _loadFavPokemons();
    });
  }

  void _onPokeListModelReady(PokemonFavViewModel model) {
    _viewModel = model;
    _loadFavPokemons();
  }

  void _loadFavPokemons() {
    _viewModel.getFavPokemons().then((list) {
      if (list != null) {
        if (mounted) {
          setState(() {
            favPokemons.clear();
            favPokemons.addAll(list);
          });
        }
      }
    });
  }
}
