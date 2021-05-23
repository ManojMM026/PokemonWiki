import 'package:mypokedex/api/api.dart';
import 'package:mypokedex/pokedex/dao/poke_by_type_dao.dart';
import 'package:mypokedex/pokedex/dao/poke_list_dao.dart';
import 'package:mypokedex/pokedex/dao/type_dao.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/types_pokemon_response.dart';
import 'package:mypokedex/pokedex/model/response/types_pokemon_response.dart'
    as Pokemon;
import 'package:mypokedex/util/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:mypokedex/util/util.dart';

class PokedexTypeRepo {
  final Api api;
  final TypeDao typeDao;
  final PokemonByTypeDao pokeTypeDao;
  final PokeListDao pokeListDao;

  PokedexTypeRepo({this.api, this.typeDao, this.pokeListDao, this.pokeTypeDao});

  Future<List<TypeX>> getPokemonTypes({bool isForceRefresh = false}) async {
    if (isForceRefresh) {
      PokemonTypeResponse response = await _requestTypes();
      return Future.value(response.results);
    } else {
      List<TypeX> types = await typeDao.getAllTypes();
      if (types == null || types.isEmpty) {
        PokemonTypeResponse response = await _requestTypes();
        types = response.results;
      }
      return Future.value(types);
    }
  }

  ///request pokemon types
  Future<PokemonTypeResponse> _requestTypes() async {
    Response response = await api.get(endPoint: AppConstants.pokemonTypes);
    if (response != null && response.data != null) {
      PokemonTypeResponse details = PokemonTypeResponse.fromJson(response.data);
      // await speciesDao.insert(details);
      await typeDao.insertPokemonList(details.results);
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }

  Future<TypesPokemonResponse> getPokemonsByType(
      {bool isForceRefresh = false, String url}) async {
    if (isForceRefresh) {
      TypesPokemonResponse response = await _requestPokeomnsByTypes();
      return Future.value(response);
    } else {
      TypesPokemonResponse pokemon = await pokeTypeDao.getPokemonByTypeId(
          id: int.tryParse(extractTypeId(url)));
      if (pokemon == null) {
        pokemon = await _requestPokeomnsByTypes(url: url);
      }
      return Future.value(pokemon);
    }
  }

  ///request pokemons by types
  Future<TypesPokemonResponse> _requestPokeomnsByTypes({String url}) async {
    Response response = await api.get(endPoint: url);
    if (response != null && response.data != null) {
      TypesPokemonResponse details =
          TypesPokemonResponse.fromJson(response.data);
      await pokeTypeDao.insert(details);
      details.pokemon.forEach((element) {
        print('Type pokemon : ${element.toJson()}');
      });
      for (Pokemon.Pokemon pokemon in details.pokemon) {
        await pokeListDao.insert(pokemon.pokemon);
      }
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }
}
