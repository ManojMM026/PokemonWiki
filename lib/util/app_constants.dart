enum ImageType { ASSET, NETWORK, FILE }
enum LoadingState { IDLE, LOADING, SUCCESS, FAIL }

class AppConstants {
  static int connectionTimeOut = 30000;
  static int responseTimeOut = 30000;
  static const int MAX_RETRIES = 3;

  static String baseUrl = "https://pokeapi.co/api/v2/";

  static int animationDuration = 300;
  static int animationDurationShort = 300;
  static int animationDurationDelay = 400;

  static String pokemon = 'pokemon';
  static String pokemonImageUrl =
      'https://pokeres.bastionbot.org/images/pokemon/';

  static String pokemonSpeciesDetails = 'pokemon-species/';
  static String pokemonTypes = 'type/';
  static String pokemonRegions = 'region/';
  static String pokedex = 'pokedex/';

  static const String DB = "Pokemon.db";
  static const String POKE_COUNT = "POKE_COUNT";

  static const int DB_VERSION = 1;

  static const int limit = 50;

  static var portraitGridCount=2;
  static var landScapeGridCount=4;
  static var portraitTypeGridCount = 3;
  static var landScapeTypeGridCount = 6;
}
