import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mypokedex/api/api.dart';
import 'package:dio/dio.dart';
import 'package:mypokedex/pokedex/dao/evolution_dao.dart';
import 'package:mypokedex/pokedex/dao/poke_list_dao.dart';
import 'package:mypokedex/pokedex/dao/pokemon_dao.dart';
import 'package:mypokedex/pokedex/dao/species_dao.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_evolutions_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/shared_pref_manager.dart';
import 'package:mypokedex/util/util.dart';
import 'package:sembast/sembast.dart';

class PokedexRepo {
  Api api;
  PokeListDao pokeListDao;
  PokemonDao pokemonDao;
  SpeciesDao speciesDao;
  EvolutionDao evolutionDao;

  PokedexRepo(
      {this.api,
      this.pokeListDao,
      this.pokemonDao,
      this.speciesDao,
      this.evolutionDao});

  ///get pokemon list by limit
  Future<PokemonList> getPokemonList(
      {int limit = AppConstants.limit, bool isForceRefresh = false}) async {
    int count = await pokeCount();
    print('Current Count : $count');
    if (isForceRefresh) {
      PokemonList list = await _requestPokemonList(limit: limit, count: count);
      return Future.value(list);
    } else {
      if (count == 0) {
        PokemonList list =
            await _requestPokemonList(limit: limit, count: count);
        return Future.value(list);
      } else {
        List<Result> list = await pokeListDao.getAllPokemons();
        PokemonList pokemonList = PokemonList(results: list);
        return Future.value(pokemonList);
      }
    }
  }

  Future updatePokeCount(int countToUpdate) async {
    int currentCount = await pokeCount();
    return SharedPrefManager.instance.saveToPref(
        key: AppConstants.POKE_COUNT,
        value: (countToUpdate + currentCount).toString());
  }

  Future<int> pokeCount() async {
    var count = await SharedPrefManager.instance
        .getPrefValues(key: AppConstants.POKE_COUNT);
    return count == null || count.isEmpty ? 0 : int.tryParse(count);
  }

  Future<PokemonList> _requestPokemonList(
      {int limit = AppConstants.limit, int count = 0}) async {
    Map<String, int> queryParameter = {"limit": limit, "offset": count};
    Response response = await api.get(
        endPoint: AppConstants.pokemon, queryParameters: queryParameter);
    if (response != null && response.data != null) {
      PokemonList list = PokemonList.fromJson(response.data);
      if (list.results != null) {
        await pokeListDao.insertPokemonList(list.results);
        await updatePokeCount(list.results.length);
      }
      return Future.value(list);
    } else {
      return Future.error('No Data');
    }
  }

  ///Get pokemon details by url
  Future<Pokemon> getPokemonDetails(
      {bool isForceRefresh = false, @required String url}) async {
    print('Pokemon details species: $url');
    if (isForceRefresh) {
      print('Get force fetch pokemon details ');
      Pokemon pokemon = await _requestPokemonDetails(url: url);
      return Future.value(pokemon);
    } else {
      int id = -1;
      if (url.contains(AppConstants.pokemonSpeciesDetails)) {
        id = int.tryParse(extractIdFromSpecies(url));
      } else {
        id = int.tryParse(extractPokemonId(url));
      }
      if (id != null) {
        PokemonDetails details = await pokemonDao.getPokemonById(pokemonId: id);
        PokemonSpeciesDetails speciesDetails =
            await speciesDao.getPokemonSpeciesById(pokemonId: id);
        Pokemon pokemon =
            Pokemon(speciesDetails: speciesDetails, details: details);
        if (details == null || speciesDetails == null) {
          pokemon = await _requestPokemonDetails(url: url);
        }
        print('Found in db pokemon details ');
        return Future.value(pokemon);
      } else {
        Pokemon pokemon = await _requestPokemonDetails(url: url);
        return Future.value(pokemon);
      }
    }
  }

  ///request pokemon details by url
  Future<Pokemon> _requestPokemonDetails({@required String url}) async {
    Response response = await api.get(endPoint: url);
    if (response != null && response.data != null) {
      PokemonDetails details = PokemonDetails.fromJson(response.data);
      PokemonSpeciesDetails species = await getPokemonSpecies(id: details.id);
      await pokemonDao.insert(details);
      await speciesDao.insert(species);
      Pokemon pokemon = Pokemon(details: details, speciesDetails: species);
      return Future.value(pokemon);
    } else {
      return Future.error('No Data');
    }
  }

  ///Get pokemon evolutions
  Future<PokemonEvolution> getPokemonEvolution(
      {bool isForceRefresh = false, @required String url}) async {
    if (isForceRefresh) {
      PokemonEvolution evolution = await _requestPokemonEvolutions(url: url);
      return Future.value(evolution);
    } else {
      PokemonEvolution evolution =
          await evolutionDao.getPokemonByEvolutionChain(url: url);
      if (evolution == null) {
        evolution = await _requestPokemonEvolutions(url: url);
      }
      return Future.value(evolution);
    }
  }

  ///request pokemon evolutions by url
  Future<PokemonEvolution> _requestPokemonEvolutions({String url}) async {
    print('Evolution url : $url');
    Response response = await api.get(endPoint: url);
    if (response != null && response.data != null) {
      //get evolution list
      List<dynamic> list =
          json.decode(json.encode(response.data))["chain"]["evolves_to"];
      Set<Species> evolutions = Set();
      Species basePokemon = Species.fromJson(
          json.decode(json.encode(response.data))["chain"]["species"]);
      print('Base Pokemon :${basePokemon.name}');
      evolutions.add(basePokemon);
      //iterate through chains to get all forms
      list.forEach((evolves) {
        Species species = Species.fromJson(evolves["species"]);
        Species sp =
            evolutionForm("evolves_to", "species", evolves["evolves_to"]);
        if (species != null) {
          evolutions.add(species);
        }
        if (sp != null) {
          evolutions.add(sp);
        }
      });

      PokemonEvolution pokemonEvolution =
          PokemonEvolution(species: evolutions.toList(), evolutionChain: url);
      evolutionDao.insert(pokemonEvolution);
      return Future.value(pokemonEvolution);
    } else {
      return Future.error('No Data');
    }
  }

  ///Get evolution species from species chain
  Species evolutionForm(
      String searchKeyword, String searchObject, List<dynamic> evolvesTo) {
    Species species;
    if (evolvesTo.isNotEmpty) {
      for (int i = 0; i < evolvesTo.length; i++) {
        species = Species.fromJson(evolvesTo[i]["species"]);
        print('Species : ${species.name}');
        evolvesTo = evolvesTo[i][searchKeyword];
        evolutionForm(searchKeyword, searchObject, evolvesTo);
      }
    }
    return species;
  }

  ///Get pokemon species details by url
  Future<PokemonSpeciesDetails> getPokemonSpecies(
      {bool isForceRefresh = false, @required int id}) async {
    if (isForceRefresh) {
      PokemonSpeciesDetails details = await _requestSpecies(id: id);
      return Future.value(details);
    } else {
      PokemonSpeciesDetails details =
          await speciesDao.getPokemonSpeciesById(pokemonId: id);
      if (details == null) {
        details = await _requestSpecies(id: id);
      }
      return Future.value(details);
    }
  }

  ///request pokemon species
  Future<PokemonSpeciesDetails> _requestSpecies({@required int id}) async {
    Response response = await api.get(
        endPoint: AppConstants.pokemonSpeciesDetails + id.toString());
    if (response != null && response.data != null) {
      PokemonSpeciesDetails details =
          PokemonSpeciesDetails.fromJson(response.data);
      await speciesDao.insert(details);
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }

  Future<Stream<List<RecordSnapshot<int, Map<String, dynamic>>>>>
      listenPokeDetailsStream() async {
    Stream<List<RecordSnapshot<int, Map<String, dynamic>>>> stream =
        await pokemonDao.listenPokemonSpeciesDetails();
    return Future.value(stream);
  }
}
