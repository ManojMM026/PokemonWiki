import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:strings/strings.dart';

class PokemonTypes extends StatelessWidget {
  final List<Type> pokemonTypes;
  final PokemonColor color;

  PokemonTypes({@required this.pokemonTypes, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: ListView.builder(
          padding: EdgeInsets.only(top: 5),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            TypeX type = pokemonTypes[index].type;
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 5, left: index == 0 ? 0 : 5),
              decoration: BoxDecoration(
                  color: getTextColor(color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15)),
              child: caption(context, capitalize(type.name),
                  alignCenter: true, color: getTextColor(color)),
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: pokemonTypes == null ? 0 : pokemonTypes.length),
    );
  }
}
