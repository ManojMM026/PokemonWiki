import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_view_model.dart';
import 'package:strings/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/image_loader.dart';
import 'package:mypokedex/widget/pokemon_type.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  final Result pokemon;
  final Function onCardTapped;

  PokemonCard({@required this.pokemon, this.onCardTapped});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PokemonDetailsViewModel>(
      model: PokemonDetailsViewModel(repo: Provider.of(context)),
      onModelReady: (model) => model.getPokemonDetails(url: pokemon.url),
      builder: (context, model, child) {
        Pokemon pokemon = model.details;
        return AnimatedCrossFade(
          layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  child: bottomChild,
                  key: bottomChildKey,
                ),
                Positioned(
                  child: topChild,
                  key: topChildKey,
                ),
              ],
            );
          },
          firstChild: _loadEmptyCard(),
          secondChild: _loadPokemonCard(context, pokemon),
          crossFadeState: pokemon == null || pokemon.details == null
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: Duration(milliseconds: AppConstants.animationDurationShort),
        );
      },
    );
  }

  ///Create pokemon grid card and load data
  Widget _loadPokemonCard(BuildContext context, Pokemon pokemon) {
    if (pokemon == null || pokemon.details == null) {
      return _loadEmptyCard();
    }
    return InkWell(
      onTap: () => onCardTapped(pokemon),
      borderRadius: BorderRadius.circular(15),
      highlightColor: getColor(pokemon.speciesDetails.color).withOpacity(0.5),
      splashColor: getColor(pokemon.speciesDetails.color).withOpacity(0.5),
      focusColor: getColor(pokemon.speciesDetails.color).withOpacity(0.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.all(5),
        child: Stack(
          children: <Widget>[
            _buildColorCard(context, pokemon),
            _buildPokemonImage(context, pokemon),
            _buildPokemonInfo(context, pokemon),
          ],
        ),
      ),
    );
  }

  ///build name & type view
  Widget _buildPokemonInfo(BuildContext context, Pokemon pokemon) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          subtitle1(context, capitalize(pokemon.details.name),
              color: getTextColor(pokemon.speciesDetails.color)),
          _buildTypes(pokemon.details.types, pokemon.speciesDetails.color),
        ],
      ),
    );
  }

  ///build pokemon color card
  Widget _buildColorCard(BuildContext context, Pokemon pokemon) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 12,
                offset: Offset(0, 0),
                spreadRadius: -7,
              )
            ],
            color: getColor(pokemon.speciesDetails.color),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  ///create pokemon image
  Widget _buildPokemonImage(BuildContext context, Pokemon pokemon) {
    return _loadPokemonImage(
        pokemon: pokemon,
        url: AppConstants.pokemonImageUrl +
            pokemon.details.id.toString() +
            ".png");
  }

  ///load place holder view
  Widget _loadEmptyCard() {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: -7,
          )
        ],
      ),
    );
  }

  ///Create oval shape and load pokemon over it
  Widget _loadPokemonImage({String url, Pokemon pokemon}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getTextColor(pokemon.speciesDetails.color)
                    .withOpacity(0.08)),
            child: Hero(
              transitionOnUserGestures: true,
              tag: pokemon.details.id.toString() + " ",
              child: AppImageLoader.withImage(
                  imageUrl: url,
                  imageType: ImageType.NETWORK,
                  showCircleImage: false,
                  roundCorners: false),
            ),
          ),
        ),
      ),
    );
  }

  ///load pokemon type. Fire, grass, water
  Widget _buildTypes(List<Type> types, PokemonColor color) {
    if (types == null) {
      return Container();
    }
    return PokemonTypes(pokemonTypes: types, color: color);
  }
}
