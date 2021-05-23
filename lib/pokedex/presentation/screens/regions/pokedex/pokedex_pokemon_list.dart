import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/viewmodel/pokedex_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:mypokedex/widget/poke_grid.dart';
import 'package:provider/provider.dart';

class PokedexPokemonList extends StatefulWidget {
  final String url;

  PokedexPokemonList({this.url});

  @override
  _PokedexPokemonListState createState() => _PokedexPokemonListState();
}

class _PokedexPokemonListState extends State<PokedexPokemonList> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<PokedexViewModel>(
      model: PokedexViewModel(repo: Provider.of(context)),
      onModelReady: (model) => _onPokedexViewModel(model),
      builder: (context, model, child) {
        if (model.pokemonList == null || model.pokemonList.isEmpty) {
          return PlaceHolderView(
            placeHolderText: Strings.placeHolder,
          );
        }
        return _buildGridView(model.pokemonList);
      },
    );
  }

  _onPokedexViewModel(PokedexViewModel model) {
    model.getPokemonsByPokeDex(url: widget.url);
  }

  Widget _buildGridView(List<Result> pokemonList) {
    return PokeGrid(
      onCardTapped: _onCardTapped,
      pokemons: pokemonList,
    );
  }

  _onCardTapped(Pokemon pokemon) {
    Navigator.pushNamed(context, RoutePaths.POKEMON_DETAILS,
        arguments: pokemon);
  }
}
