import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:strings/strings.dart';
import 'package:animate_do/animate_do.dart';
class Stats extends StatelessWidget {
  final Pokemon pokemon;

  Stats({this.pokemon});

  @override
  Widget build(BuildContext context) {
    if (pokemon.details.stats == null || pokemon.details.stats.isEmpty) {
      return Container();
    }
    return Container(
      color: getColor(pokemon.speciesDetails.color),
      child: FadeIn(
        delay: Duration(milliseconds: AppConstants.animationDuration),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Stat stat = pokemon.details.stats[index];
            print(
                'State ${capitalize(stat.stat.name)} ${stat.base_stat.toDouble()}');
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: subtitle1(context, capitalize(stat.stat.name),
                          color: getTextColor(pokemon.speciesDetails.color)),
                    ),
                    Flexible(
                      flex: 6,
                      child: LinearProgressIndicator(
                        value: stat.base_stat.toDouble() / 100,
                        backgroundColor:
                            getSliderColor(pokemon.speciesDetails.color),
                        valueColor: AlwaysStoppedAnimation(
                            getTextColor(pokemon.speciesDetails.color)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: pokemon.details.stats.length,
        ),
      ),
    );
  }
}
