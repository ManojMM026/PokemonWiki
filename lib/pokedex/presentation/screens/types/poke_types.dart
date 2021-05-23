import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/types_poke_list.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/viewmodel/pokemon_types_view_model.dart';
import 'package:mypokedex/resources/strings.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/color_util.dart';
import 'package:mypokedex/util/hex_color.dart';
import 'package:mypokedex/widget/app_svg_loader.dart';
import 'package:mypokedex/widget/base_widget.dart';
import 'package:mypokedex/widget/place_holder_view.dart';
import 'package:mypokedex/widget/text_util.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mypokedex/util/string_util.dart';
import 'package:animations/animations.dart';

class PokeTypes extends StatefulWidget {
  @override
  _PokeTypesState createState() => _PokeTypesState();
}

class _PokeTypesState extends State<PokeTypes> {
  Map<String, Color> color = {
    "normal": HexColor("#c2b5a8"),
    "fire": red,
    "water": blue,
    "electric": yellow,
    "grass": Colors.green,
    "ice": white,
    "fighting": HexColor("#800000"),
    "poison": purple,
    "ground": HexColor("#C2B280"),
    "flying": HexColor("#A98FF3"),
    "psychic": HexColor("#FF69B4"),
    "bug": leafGreen,
    "shadow": Colors.grey[850],
    "rock": HexColor("#A52A2A"),
    "ghost": HexColor("#301934"),
    "dragon": HexColor("#4B0082"),
    "dark": HexColor("#004242"),
    "steel": HexColor("#8C92AC"),
    "fairy": HexColor("#f984e5"),
    "unknown": HexColor("#000000"),
  };
  Map<String, Color> textColor = {
    "normal": Colors.white,
    "fire": Colors.white,
    "water": Colors.white,
    "electric": Colors.black,
    "grass": Colors.white,
    "ice": Colors.black,
    "fighting": Colors.white,
    "poison": Colors.white,
    "ground": Colors.white,
    "flying": Colors.black,
    "psychic": Colors.black,
    "bug": Colors.white,
    "rock": Colors.white,
    "ghost": Colors.white,
    "dragon": Colors.white,
    "dark": Colors.white,
    "steel": Colors.white,
    "fairy": Colors.black,
    "shadow": Colors.white,
    "unknown": Colors.white,
  };
  Map<String, String> typeIcons = {
    "normal": "assets/icons/normal.svg",
    "fire": "assets/icons/fire.svg",
    "water": "assets/icons/water.svg",
    "electric": "assets/icons/electric.svg",
    "grass": "assets/icons/grass.svg",
    "ice": "assets/icons/ice.svg",
    "fighting": "assets/icons/fighting.svg",
    "poison": "assets/icons/poison.svg",
    "ground": "assets/icons/ground.svg",
    "flying": "assets/icons/flying.svg",
    "psychic": "assets/icons/psychic.svg",
    "shadow": "assets/icons/shadow.svg",
    "bug": "assets/icons/bug.svg",
    "rock": "assets/icons/rock.svg",
    "ghost": "assets/icons/ghost.svg",
    "dragon": "assets/icons/dragon.svg",
    "dark": "assets/icons/dark.svg",
    "steel": "assets/icons/steel.svg",
    "fairy": "assets/icons/fairy.svg",
    "unknown": "assets/icons/unknown.svg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildTypes(),
    );
  }

  Widget _buildTypes() {
    return BaseWidget<PokemonTypesViewModel>(
      model: PokemonTypesViewModel(repo: Provider.of(context)),
      onModelReady: (model) => model.getPokemonTypes(),
      builder: (context, model, child) {
        switch (model.state) {
          case LoadingState.IDLE:
            break;
          case LoadingState.LOADING:
            break;
          case LoadingState.SUCCESS:
            break;
          case LoadingState.FAIL:
            return PlaceHolderView(
              placeHolderText: Strings.placeHolder,
            );
          default:
            break;
        }
        if (model.pokemonTypes == null || model.pokemonTypes.isEmpty) {
          return PlaceHolderView(
            placeHolderText: Strings.placeHolder,
          );
        }
        return _buildTypeGrid(model.pokemonTypes);
      },
    );
  }

  Widget _buildTypeGrid(List<TypeX> types) {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (types == null || types.isEmpty) {
      return PlaceHolderView(
        placeHolderText: Strings.placeHolder,
      );
    }
    return FadeIn(
      delay: Duration(milliseconds: AppConstants.animationDuration),
      child: GridView.builder(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        itemCount: types != null ? types.length : 0,
        itemBuilder: (BuildContext context, int index) {
          TypeX type = types[index];
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: OpenContainer<bool>(
                transitionDuration: Duration(milliseconds: 300),
                closedElevation: 2,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                closedColor:
                    color[type.name] == null ? white : color[type.name],
                openColor: Colors.white,
                transitionType: ContainerTransitionType.fadeThrough,
                openBuilder: (BuildContext _, VoidCallback openContainer) {
                  return TypesPokeList(
                    type: type,
                  );
                },
                closedBuilder: (BuildContext _, VoidCallback openContainer) {
                  return _buildTypeCard(type, index);
                }),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: orientation == Orientation.portrait
                ? AppConstants.portraitTypeGridCount
                : AppConstants.landScapeTypeGridCount),
      ),
    );
  }

  Widget _buildTypeCard(TypeX typeX, int index) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: -7,
          )
        ],
        color: color[typeX.name] == null ? white : color[typeX.name],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            typeIcons[typeX.name] == null
                ? Container()
                : Pulse(
                    infinite: true,
                    duration: Duration(milliseconds: 1000 + 10 * index),
                    delay: Duration(milliseconds: 500 + 300 * index),
                    child: AppSvgLoader(
                      color: Colors.white,
                      svg: typeIcons[typeX.name],
                      svgSize: Size(30, 30),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: subtitle2(context, typeX.name.capitalize(),
                  color: textColor[typeX.name] == null
                      ? Colors.black
                      : textColor[typeX.name]),
            ),
          ],
        ),
      ),
    );
  }
}
