import 'package:mypokedex/util/app_constants.dart';

class Strings {
  static const String appName = 'Pokédex';
  static const String loading = 'Loading..';
  static const String initializing = 'Initializing';
  static const String placeHolder = "Gotta Catch Em! All";
  static const String fail = 'Something went wrong!';

  static const String types = "Pokémon Types";
  static const String tabType = "Pokémon Types";
  static const String tabFav = "Favourites";
  static const String tabAllPokemon = "All Pokémons";
  static const String tabRegion = "Regions";
  static const String pokedex = "Pokédex";
  static const String starterPokemon = "Starter Pokémon";
  static const String trainersPokemon = "Trainers Pokémon";

  static var regions = "Pokémon Regions";

  static String updateSuccess = "Added to favourite";
  static String removeFavSuccess = "Removed from favourite";

  static String selectPokeDex = "Select Pokédex";

  static String noInternetConnection = "No internet connection";
  static String retry = "Retry";

  static Map<int, List<String>> ashPokeList = {
    1: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/12/",
      AppConstants.baseUrl + AppConstants.pokemon + "/17/",
      AppConstants.baseUrl + AppConstants.pokemon + "/1/",
      AppConstants.baseUrl + AppConstants.pokemon + "/6/",
      AppConstants.baseUrl + AppConstants.pokemon + "/7/",
      AppConstants.baseUrl + AppConstants.pokemon + "/99/",
      AppConstants.baseUrl + AppConstants.pokemon + "/89/",
      AppConstants.baseUrl + AppConstants.pokemon + "/57/",
      AppConstants.baseUrl + AppConstants.pokemon + "/128/",
      AppConstants.baseUrl + AppConstants.pokemon + "/131/",
      AppConstants.baseUrl + AppConstants.pokemon + "/143/",
    ],
    2: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/152/",
      AppConstants.baseUrl + AppConstants.pokemon + "/155/",
      AppConstants.baseUrl + AppConstants.pokemon + "/158/",
      AppConstants.baseUrl + AppConstants.pokemon + "/164/",
      AppConstants.baseUrl + AppConstants.pokemon + "/231/",
      AppConstants.baseUrl + AppConstants.pokemon + "/214/",
      AppConstants.baseUrl + AppConstants.pokemon + "/15/",
    ],
    3: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/277/",
      AppConstants.baseUrl + AppConstants.pokemon + "/253/",
      AppConstants.baseUrl + AppConstants.pokemon + "/341/",
      AppConstants.baseUrl + AppConstants.pokemon + "/324/",
      AppConstants.baseUrl + AppConstants.pokemon + "/362/"
    ],
    4: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/190/",
      AppConstants.baseUrl + AppConstants.pokemon + "/398/",
      AppConstants.baseUrl + AppConstants.pokemon + "/389/",
      AppConstants.baseUrl + AppConstants.pokemon + "/418/",
      AppConstants.baseUrl + AppConstants.pokemon + "/392/",
      AppConstants.baseUrl + AppConstants.pokemon + "/472/",
      AppConstants.baseUrl + AppConstants.pokemon + "/443/",
    ],
    5: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/521/",
      AppConstants.baseUrl + AppConstants.pokemon + "/501/",
      AppConstants.baseUrl + AppConstants.pokemon + "/499/",
      AppConstants.baseUrl + AppConstants.pokemon + "/495/",
      AppConstants.baseUrl + AppConstants.pokemon + "/559/",
      AppConstants.baseUrl + AppConstants.pokemon + "/542/",
      AppConstants.baseUrl + AppConstants.pokemon + "/525/",
      AppConstants.baseUrl + AppConstants.pokemon + "/536/",
      AppConstants.baseUrl + AppConstants.pokemon + "/553/",
      AppConstants.baseUrl + AppConstants.pokemon + "/6/",
    ],
    6: [
      AppConstants.baseUrl + AppConstants.pokemon + "/658/",
      AppConstants.baseUrl + AppConstants.pokemon + "/663/",
      AppConstants.baseUrl + AppConstants.pokemon + "/701/",
      AppConstants.baseUrl + AppConstants.pokemon + "/706/",
      AppConstants.baseUrl + AppConstants.pokemon + "/715/",
      AppConstants.baseUrl + AppConstants.pokemon + "/25/"
    ],
    7: [
      AppConstants.baseUrl + AppConstants.pokemon + "/479/",
      AppConstants.baseUrl + AppConstants.pokemon + "/809/",
      AppConstants.baseUrl + AppConstants.pokemon + "/804/",
      AppConstants.baseUrl + AppConstants.pokemon + "/722/",
      AppConstants.baseUrl + AppConstants.pokemon + "/727/",
      AppConstants.baseUrl + AppConstants.pokemon + "/745/"
    ],
    8: [
      AppConstants.baseUrl + AppConstants.pokemon + "/25/",
      AppConstants.baseUrl + AppConstants.pokemon + "/149/",
      AppConstants.baseUrl + AppConstants.pokemon + "/94/",
      AppConstants.baseUrl + AppConstants.pokemon + "/448/",
      AppConstants.baseUrl + AppConstants.pokemon + "/83/",
      AppConstants.baseUrl + AppConstants.pokemon + "/882/"
    ],
  };
}
