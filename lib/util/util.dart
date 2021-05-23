import 'app_constants.dart';

String extractIdFromSpecies(String url) {
  if (url == null) {
    return "";
  }
  return url
      .replaceAll(AppConstants.baseUrl + AppConstants.pokemonSpeciesDetails, "")
      .replaceAll("/", "");
}

///extract pokemon id from pokemon url
///https://pokeapi.co/api/v2/pokemon/1/
String extractPokemonId(String url) {
  if (url == null) {
    return "";
  }
  return url
      .replaceAll(AppConstants.baseUrl + AppConstants.pokemon, "")
      .replaceAll("/", "");
}

String extractTypeId(String url) {
  if (url == null) {
    return "";
  }
  return url
      .replaceAll(AppConstants.baseUrl + AppConstants.pokemonTypes, "")
      .replaceAll("/", "");
}

String extractRegionId(String url) {
  if (url == null) {
    return "";
  }
  return url
      .replaceAll(AppConstants.baseUrl + AppConstants.pokemonRegions, "")
      .replaceAll("/", "");
}

String extractPokedexId(String url) {
  if (url == null) {
    return "";
  }
  return url
      .replaceAll(AppConstants.baseUrl + AppConstants.pokedex, "")
      .replaceAll("/", "");
}
