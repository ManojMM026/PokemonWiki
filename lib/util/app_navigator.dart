import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/details/pokemon_detail_page.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/poke_types.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/pokedex_home.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/types_poke_list.dart';

///All screen path reference names.
class RoutePaths {
  static const String POKEMON_DETAILS = "PokemonDetails";
  static const String POKEMON_TYPES = "PokemonTypes";
  static const String POKEMON_HOME = "PokemonHome";
  static const String LIST_POKEMON_BY_TYPES = "PokeListByTypes";
}

///Returns generated route paths to navigate to.
class AppNavigator {
  AppNavigator._privateConstructor();

  static final AppNavigator _instance = AppNavigator._privateConstructor();

  static AppNavigator get instance {
    return _instance;
  }

  ///Generate route path based on @routeSettings passed.
  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePaths.POKEMON_DETAILS:
        {
          return CupertinoPageRoute(
              settings: RouteSettings(name: RoutePaths.POKEMON_DETAILS),
              builder: (context) => PokemonDetailsPage(
                    pokemon: routeSettings.arguments,
                  ));
        }
      case RoutePaths.LIST_POKEMON_BY_TYPES:
        {
          return CupertinoPageRoute(
              settings: RouteSettings(name: RoutePaths.LIST_POKEMON_BY_TYPES),
              builder: (context) => TypesPokeList(
                    type: routeSettings.arguments,
                  ));
        }
      case RoutePaths.POKEMON_TYPES:
        {
          return CupertinoPageRoute(
              settings: RouteSettings(name: RoutePaths.POKEMON_DETAILS),
              builder: (context) => PokeTypes());
        }
      case RoutePaths.POKEMON_HOME:
        {
          return CupertinoPageRoute(
              settings: RouteSettings(name: RoutePaths.POKEMON_HOME),
              builder: (context) => PokeDexHome());
        }

      default:
        {
          return CupertinoPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No route defined for ${routeSettings.name}'),
                    ),
                  ));
        }
    }
  }
}
