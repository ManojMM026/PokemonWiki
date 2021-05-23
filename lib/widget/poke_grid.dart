import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/pokemon_card.dart';
import 'package:mypokedex/util/app_constants.dart';

class PokeGrid extends StatelessWidget {
  final List<Result> pokemons;
  final Function onCardTapped;

  PokeGrid({this.pokemons, this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: pokemons != null ? pokemons.length : 0,
      itemBuilder: (BuildContext context, int index) {
        Result pokemon = pokemons[index];
        return PokemonCard(
          pokemon: pokemon,
          onCardTapped: onCardTapped,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait
              ? AppConstants.portraitGridCount
              : AppConstants.landScapeGridCount),
    );
  }
}
