import 'package:mypokedex/api/api.dart';
import 'package:dio/dio.dart';
import 'package:mypokedex/pokedex/dao/poke_list_dao.dart';
import 'package:mypokedex/pokedex/dao/pokedex_detail_dao.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokedex_details_response.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/util.dart';

class RegionDexRepo {
  Api api;
  PokedexDetailDao detailDao;
  PokeListDao pokeListDao;

  RegionDexRepo({
    this.api,
    this.detailDao,
    this.pokeListDao,
  });

  Future<PokedexDetailResponse> getPokeDexDetail(
      {bool isForceRefresh = false, String url}) async {
    print('Pokedex url : $url');
    if (isForceRefresh) {
      PokedexDetailResponse response = await _requestPokedexDetails(url: url);
      return Future.value(response);
    } else {
      String id = extractPokedexId(url);
      PokedexDetailResponse detail =
          await detailDao.getPokedexDetailById(id: int.tryParse(id));
      if (detail == null) {
        detail = await _requestPokedexDetails(url: url);
      }
      return Future.value(detail);
    }
  }

  ///request pokemon regions
  Future<PokedexDetailResponse> _requestPokedexDetails({String url}) async {
    Response response = await api.get(endPoint: url);
    if (response != null && response.data != null) {
      PokedexDetailResponse details =
          PokedexDetailResponse.fromJson(response.data);
      // await speciesDao.insert(details);
      try {
        await detailDao.insert(details);
      } catch (e) {
        print('Error in storing pokedex detail $e');
      }
      for (PokemonEntries pokemon in details.pokemonEntries) {
        try {
          String id = extractIdFromSpecies(pokemon.pokemonSpecies.url);

          // https://pokeapi.co/api/v2/pokemon/50/
          Result result = Result(
            id: int.tryParse(id),
            url: AppConstants.baseUrl + AppConstants.pokemon + "/" + id + "/",
            name: pokemon.pokemonSpecies.name,
            isFav: false,
          );
          // print('Pokemon id ${result.toJson()}');
          await pokeListDao.insert(result);
        } catch (e) {
          print('Error in storing pokedex pokemon $e');
        }
      }
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }
}
