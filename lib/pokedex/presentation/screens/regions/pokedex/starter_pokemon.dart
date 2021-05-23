import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/details/pokemon_detail_page.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/viewmodel/pokemon_view_model.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/app_navigator.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/image_loader.dart';
import 'package:mypokedex/widget/pokemon_type.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';
import 'package:mypokedex/util/string_util.dart';
import 'package:animations/animations.dart';


class StarterPokemon extends StatefulWidget {
  final List<Result> pokemons;

  StarterPokemon(this.pokemons);

  @override
  _StarterPokemonState createState() => _StarterPokemonState();
}

class _StarterPokemonState extends State<StarterPokemon> {
  double _cardHeight = 0;
  Orientation _orientation;

  @override
  Widget build(BuildContext context) {
    _orientation = MediaQuery.of(context).orientation;
    _cardHeight = _orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height / 4.5
        : double.maxFinite;
    return MediaQuery.of(context).orientation == Orientation.portrait
        ? _buildList()
        : _buildGrid();
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: widget.pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        Result pokemon = widget.pokemons[index];
        return _buildPokeCard(pokemon);
      },
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: widget.pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        Result pokemon = widget.pokemons[index];
        return _buildPokeCard(
          pokemon,
        );
      },
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );
  }

  Widget _buildPokeCard(Result pokemon) {
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

  void onCardTapped(Pokemon pokemon) {
    Navigator.pushNamed(context, RoutePaths.POKEMON_DETAILS,
        arguments: pokemon);
  }

  ///Create pokemon grid card and load data
  Widget _loadPokemonCard(BuildContext context, Pokemon pokemon) {
    if (pokemon == null || pokemon.details == null) {
      return _loadEmptyCard();
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: OpenContainer<bool>(
          transitionDuration: Duration(milliseconds: 500),
          closedElevation: 2,
          closedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          closedColor: getColor(pokemon.speciesDetails.color),
          openColor: getColor(pokemon.speciesDetails.color),
          transitionType: ContainerTransitionType.fade,
          openBuilder: (BuildContext _, VoidCallback openContainer) {
            return PokemonDetailsPage(
              pokemon: pokemon,
            );
          },
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent,
              ),
              child: Stack(
                children: <Widget>[
                  _buildColorCard(context, pokemon),
                  _buildPokemonImage(context, pokemon),
                  _buildPokemonInfo(context, pokemon),
                ],
              ),
            );
          }),
    );

    /*return InkWell(
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
        margin: EdgeInsets.all(10),
        child: Stack(
          children: <Widget>[
            _buildColorCard(context, pokemon),
            _buildPokemonImage(context, pokemon),
            _buildPokemonInfo(context, pokemon),
          ],
        ),
      ),
    );*/
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
          headline5(context, pokemon.details.name.capitalize(),
              color: getTextColor(pokemon.speciesDetails.color)),
          _buildTypes(pokemon.details.types, pokemon.speciesDetails.color),
        ],
      ),
    );
  }

  ///build pokemon color card
  Widget _buildColorCard(BuildContext context, Pokemon pokemon) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 2,
      color: getColor(pokemon.speciesDetails.color),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: _cardHeight,
      ),
    );
  }

  ///create pokemon image
  Widget _buildPokemonImage(BuildContext context, Pokemon pokemon) {
    return SizedBox(
      height: _cardHeight,
      child: _loadPokemonImage(
          pokemon: pokemon,
          url: AppConstants.pokemonImageUrl +
              pokemon.details.id.toString() +
              ".png"),
    );
  }

  ///load place holder view
  Widget _loadEmptyCard() {
    return Container(
      margin: EdgeInsets.all(5),
      height: _cardHeight,
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
        widthFactor: _orientation == Orientation.portrait ? null : 0.7,
        heightFactor: _orientation == Orientation.portrait ? null : 0.7,
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
