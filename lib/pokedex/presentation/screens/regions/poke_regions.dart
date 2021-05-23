import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/poke_region_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/region_poke_list.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/viewmodel/pokemon_regions_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/image_loader.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mypokedex/util/string_util.dart';
import 'package:animations/animations.dart';

class PokemonRegions extends StatefulWidget {
  @override
  _PokemonRegionsState createState() => _PokemonRegionsState();
}

class _PokemonRegionsState extends State<PokemonRegions> {
  Map<String, String> regions = {
    "kanto": "${AppConstants.pokemonImageUrl}/145.png",
    "alola": "${AppConstants.pokemonImageUrl}785.png",
    "galar": "${AppConstants.pokemonImageUrl}890.png",
    "johto": "${AppConstants.pokemonImageUrl}244.png",
    "hoenn": "${AppConstants.pokemonImageUrl}383.png",
    "kalos": "${AppConstants.pokemonImageUrl}384.png",
    "sinnoh": "${AppConstants.pokemonImageUrl}481.png",
    "unova": "${AppConstants.pokemonImageUrl}645.png",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildRegions(),
    );
  }

  Widget _buildRegions() {
    return BaseWidget<PokemonRegionViewModel>(
      model: PokemonRegionViewModel(repo: Provider.of(context)),
      onModelReady: (model) => model.getPokemonRegions(),
      builder: (context, model, child) {
        switch (model.state) {
          case LoadingState.IDLE:
            // EasyLoading.show();
            break;
          case LoadingState.LOADING:
            // EasyLoading.show();
            break;
          case LoadingState.SUCCESS:
            // EasyLoading.dismiss();
            break;
          case LoadingState.FAIL:
            // EasyLoading.dismiss();
            break;
          default:
            // EasyLoading.dismiss();
            break;
        }
        if (model.regions == null || model.regions.isEmpty) {
          return PlaceHolderView(
            placeHolderText: Strings.placeHolder,
          );
        }
        return _buildRegionGrid(model.regions);
      },
    );
  }

  Widget _buildRegionGrid(List<PokeRegions> regions) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return FadeIn(
      delay: Duration(milliseconds: AppConstants.animationDuration),
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: regions != null ? regions.length : 0,
        itemBuilder: (BuildContext context, int index) {
          PokeRegions region = regions[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: OpenContainer<bool>(
                transitionDuration: Duration(milliseconds: 300),
                closedElevation: 2,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                closedColor: white,
                openColor: white,
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return RegionPokeList(
                    region: region,
                  );
                },
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return _buildRegionCard(region, index);
                }),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: orientation == Orientation.portrait
                ? AppConstants.portraitGridCount
                : AppConstants.landScapeGridCount),
      ),
    );
  }

  Widget _buildRegionCard(PokeRegions region, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: -7,
          )
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: subtitle2(
              context,
              region.name.capitalize(),
              color: Colors.black,
            ),
          ),
          _buildPokemonImage(context,
              regions[region.name] == null ? regions[0] : regions[region.name]),
        ],
      ),
    );
  }

  Widget _buildPokemonImage(BuildContext context, String url) {
    return _loadPokemonImage(url: url);
  }

  ///Create oval shape and load pokemon over it
  Widget _loadPokemonImage({String url}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        heightFactor: 0.7,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: blue.withOpacity(0.5)),
            child: AppImageLoader.withImage(
                imageUrl: url,
                imageType: ImageType.NETWORK,
                showCircleImage: false,
                roundCorners: false),
          ),
        ),
      ),
    );
  }
}
