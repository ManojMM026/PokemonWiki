import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/pokedex/model/response/pokedex_details_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/repo/region_dex_repo.dart';
import 'package:mypokedex/util/app_constants.dart';

class PokedexViewModel extends BaseViewModel {
  RegionDexRepo repo;

  PokedexViewModel({this.repo});

  List<Result> pokemonList = [];

  void getPokemonsByPokeDex({String url, bool forceRefresh = false}) async {
    setLoadingState(LoadingState.LOADING);
    try {
      PokedexDetailResponse response =
          await repo.getPokeDexDetail(url: url, isForceRefresh: forceRefresh);
      if (response != null) {
        response.pokemonEntries.forEach((element) {
          pokemonList.add(element.pokemonSpecies);
        });
        setLoadingState(LoadingState.SUCCESS);
      }
    } catch (e) {
      print(e.toString());
      setLoadingState(LoadingState.FAIL);
    }
  }
}
