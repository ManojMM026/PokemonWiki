import 'package:flutter/cupertino.dart';
import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/repo/pokedex_repo.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:mypokedex/util/app_constants.dart';

class PokemonListViewModel extends BaseViewModel {
  PokedexRepo repo;
  List<Result> pokemonList = [];

  PokemonListViewModel({@required this.repo});

  EasyRefreshController refreshController = EasyRefreshController();

  void getPokemonList({bool isForceRefresh = false}) async {
    setLoadingState(LoadingState.LOADING);
    try {
      PokemonList list =
          await repo.getPokemonList(isForceRefresh: isForceRefresh);
      if (list != null && list.results != null) {
        _refreshPokemonList(list.results);
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
