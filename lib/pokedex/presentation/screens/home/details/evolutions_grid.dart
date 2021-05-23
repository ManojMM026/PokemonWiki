import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_evolution_model.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_view_model.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mypokedex/util/util.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/image_loader.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';
import 'package:animations/animations.dart';

import 'pokemon_detail_page.dart';

class EvolutionsGrid extends StatefulWidget {
  final Pokemon pokemon;

  EvolutionsGrid({this.pokemon});

  @override
  _EvolutionsGridState createState() => _EvolutionsGridState();
}

class _EvolutionsGridState extends State<EvolutionsGrid> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return BaseWidget<PokemonEvolutionViewModel>(
      model: PokemonEvolutionViewModel(repo: Provider.of(context)),
      onModelReady: (model) => model.getEvolution(
          url: widget.pokemon.speciesDetails.evolutionChain.url),
      builder: (context, model, child) {
        if (model.details == null || model.details.species == null) {
          return Container();
        }
        List<Species> species = model.details.species;
        if (species == null || species.isEmpty) {
          return Container();
        }
        return Container(
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: species.length,
            itemBuilder: (BuildContext context, int index) {
              Species pokemon = species[index];
              return BaseWidget<PokemonDetailsViewModel>(
                  model: PokemonDetailsViewModel(repo: Provider.of(context)),
                  onModelReady: (model) =>
                      model.getPokemonDetails(url: pokemon.url),
                  builder: (context, model, child) {
                    if (model.details == null) {
                      return _loadEmptyView();
                    }
                    return FadeIn(
                      delay: Duration(
                          milliseconds: AppConstants.animationDuration),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OpenContainer(
                          closedElevation: 0,
                          openColor:
                              getColor(widget.pokemon.speciesDetails.color),
                          closedColor:
                              getColor(widget.pokemon.speciesDetails.color),
                          openBuilder: (BuildContext context,
                              void Function({Object returnValue}) action) {
                            if (model.details == null) {
                              return _loadEmptyView();
                            }
                            return PokemonDetailsPage(pokemon: model.details);
                          },
                          closedBuilder:
                              (BuildContext context, void Function() action) {
                            if (model.details == null) {
                              return Container();
                            }
                            return _buildItem(model.details, pokemon, action);
                          },
                        ),
                      ),
                    );
                  });
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
          ),
        );
      },
    );
  }

  Widget _loadEmptyView() {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
    );
  }

  Widget _buildItem(Pokemon pokemon, Species species, Function action) {
    return FadeIn(
      child: InkWell(
        onTap: action,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: _loadPokemonImage(
                    url: AppConstants.pokemonImageUrl +
                        pokemon.details.id.toString() +
                        ".png"),
              ),
              _buildRank(extractIdFromSpecies(species.url)),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: subtitle1(context, capitalize(species.name),
                    color: getTextColor(widget.pokemon.speciesDetails.color)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRank(String rank) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: bodyText2(context, "#" + rank,
          alignCenter: true,
          color: getTextColor(widget.pokemon.speciesDetails.color)),
    );
  }

  Widget _loadPokemonImage({String url}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: AppImageLoader.withImage(
          imageUrl: url,
          imageType: ImageType.NETWORK,
          showCircleImage: false,
          roundCorners: false),
    );
  }
}
