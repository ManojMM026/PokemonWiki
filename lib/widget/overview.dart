import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/pokemon_type.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:mypokedex/util/string_util.dart';

class OverView extends StatelessWidget {
  final Pokemon pokemon;

  OverView({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return _buildOverView(context);
  }

  Widget _buildOverView(BuildContext context) {
    if (pokemon.speciesDetails.flavorTextEntries == null ||
        pokemon.speciesDetails.flavorTextEntries.isEmpty) {
//      print('Desc empty');
      return Container();
    }
    Set<String> desc = Set();
    List<FlavorTextEntries> entries = pokemon.speciesDetails.flavorTextEntries;
    entries.forEach((description) {
      ///english description
      if (description.language.name == "en") {
        desc.add(
            description.flavorText.replaceAll("\n", " ").replaceAll("\f", " "));
      }
    });
    List<String> info = desc.toList().removeDuplicates();

    return Container(
      color: getColor(pokemon.speciesDetails.color),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildPokemonTypes(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: getTextColor(pokemon.speciesDetails.color)
                        .withOpacity(0.08)),
                child: subtitle2(
                    context,
                    pokemon.details.weight == null
                        ? "--"
                        : "Weight : " +
                            (pokemon.details.weight / 10).toString() +
                            " Kg",
                    color: getTextColor(pokemon.speciesDetails.color)),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: subtitle1(context, info[index],
                        color: getTextColor(pokemon.speciesDetails.color)),
                  );
                },
                itemCount: info.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonTypes() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: PokemonTypes(
            pokemonTypes: pokemon.details.types,
            color: pokemon.speciesDetails.color),
      ),
    );
  }
}
