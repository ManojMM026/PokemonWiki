import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/repo/pokedex_repo.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:sembast/sembast.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PokemonFavViewModel extends BaseViewModel {
  PokedexRepo repo;

  PokemonFavViewModel({this.repo}) {
    // listenToFavPokemons();
  }

  EasyRefreshController refreshController = EasyRefreshController();

  List<Result> favPokemons = [];

  void listenToFavPokemons() async {
    (await repo.listenPokeDetailsStream()).listen(
        (List<RecordSnapshot<int, Map<String, dynamic>>> records) async {
      print('Listen triggered ${records.length}');
      List<PokemonDetails> pokemons = [];
      records.forEach((element) {
        final pokemon = PokemonDetails.fromJson(element.value);
        pokemons.add(pokemon);
      });
      _loadFavPokemons(pokemons);
      print('Fav lists :${pokemons.length} ${favPokemons.length}');
    });
  }

  Future<List<Result>> getFavPokemons() async {
    /*List<PokemonDetails> pokemons =
        await repo.pokemonDao.getFavPokemonSpeciesList();
    if (pokemons != null) {
      _loadFavPokemons(pokemons);
    }*/
    return repo.pokeListDao.getAllFavPokemons();
    // setLoadingState(LoadingState.LOADING);
    /*repo.pokeListDao.getAllFavPokemons().then((list) {
      if (list != null) {
        list.forEach((element) {
          print('Fav result : ${element.toJson()}');
        });
        favPokemons.clear();
        favPokemons.addAll(list);
        favPokemons.forEach((element) {
          print('Fav list result : ${element.toJson()}');
        });
      }
      setLoadingState(LoadingState.SUCCESS);
    }, onError: (e) {
      setLoadingState(LoadingState.FAIL);
      print('Error in fav pokemon $e');
    });*/
  }

  void _loadFavPokemons(List<PokemonDetails> pokemons) async {
    favPokemons.clear();
    for (PokemonDetails pokemon in pokemons) {
      String url = AppConstants.baseUrl +
          AppConstants.pokemon +
          "/" +
          pokemon.id.toString() +
          "/";
      // print('Pokemon url : $url');
      Result result = await repo.pokeListDao.getPokemonByUrl(
        pokemonUrl: url,
      );
      print('Fav pokemon Result : ${result?.toJson()}');
      favPokemons.add(result);
    }
    notifyListeners();
  }

  bool isAlreadyAdded(Result result) {
    bool isAdded = false;
    Result item = favPokemons.firstWhere((element) => element.id == result.id,
        orElse: () => null);
    if (item == null) {
      isAdded = false;
    } else {
      isAdded = true;
    }
    return isAdded;
  }

  Future updatePokemon(PokemonDetails details) async {
    print('Poke details to update ${details.toJson()}');
    String url = AppConstants.baseUrl +
        AppConstants.pokemon +
        "/" +
        details.id.toString() +
        "/";
    print('Poke Url : $url');
    await repo.pokemonDao.update(details);
    Result result = await repo.pokeListDao.getPokemonByUrl(pokemonUrl: url);
    if (result == null) {
      result = Result(
          name: details.name, url: url, id: details.id, isFav: details.isFav);
      print('Result Pokemon ${result.toJson()}');
      return await repo.pokeListDao.insert(result);
    } else {
      result.isFav = details.isFav;
      return await repo.pokeListDao.update(result);
    }
  }

  Future<PokemonDetails> getUpdatedPokemonDetails({int id}) async {
    return repo.pokemonDao.getPokemonById(pokemonId: id);
  }
}
