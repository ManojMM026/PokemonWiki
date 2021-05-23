import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:strings/strings.dart';
import 'package:animate_do/animate_do.dart';

class PokemonMoves extends StatelessWidget {
  final Pokemon pokemon;

  PokemonMoves({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return _buildMoves(context);
  }

  Widget _buildMoves(BuildContext context) {
    if (pokemon.details.moves == null || pokemon.details.moves.isEmpty) {
      return Container();
    }

    return Container(
      color: getColor(pokemon.speciesDetails.color),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FadeIn(
                delay: Duration(milliseconds: AppConstants.animationDuration),
                child: Wrap(
                  children: getMoves(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getMoves(context) {
    List<Widget> widgets = [];
    pokemon.details.moves.forEach((move) {
      widgets.add(Container(
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: getSliderColor(pokemon.speciesDetails.color)
                  .withOpacity(0.3)),
          child: subtitle2(context, capitalize(move.move.name.toString()),
              color: getTextColor(pokemon.speciesDetails.color))));
    });
    return widgets;
  }
}
