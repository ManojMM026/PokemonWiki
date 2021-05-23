import 'package:flutter/cupertino.dart';
import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/types_pokemon_response.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/repo/pokedex_type_repo.dart';
import 'package:mypokedex/util/app_constants.dart';

class TypePokeListViewModel extends BaseViewModel {
  PokedexTypeRepo repo;
  List<Result> pokemonList = [];

  TypePokeListViewModel({@required this.repo});

  EasyRefreshController refreshController = EasyRefreshController();

  void getPokemonList({bool isForceRefresh = false, String url}) async {
    setLoadingState(LoadingState.LOADING);
    try {
      TypesPokemonResponse typeData = await repo.getPokemonsByType(
          isForceRefresh: isForceRefresh, url: url);
      if (typeData != null && typeData.pokemon != null) {
        List<Result> list = [];
        typeData.pokemon.forEach((element) {
          list.add(element.pokemon);
        });
        _refreshPokemonList(list);
      }
      setLoadingState(LoadingState.SUCCESS);
    } catch (e) {
      print(e);
      setLoadingState(LoadingState.FAIL);
    }
  }

  void _refreshPokemonList(List<Result> results) {
    if (results != null && results.isNotEmpty) {
      pokemonList.addAll(results);
      /* results.forEach((element) {
        print('Retrieved Pokemon---: ${element.name} ${element.url}');
      });*/
    }
  }
}
