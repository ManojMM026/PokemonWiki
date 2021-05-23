import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/poke_region_response.dart';
import 'package:mypokedex/pokedex/model/response/region_detail_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/repo/pokedex_region_repo.dart';
import 'package:mypokedex/util/app_constants.dart';

class PokemonRegionViewModel extends BaseViewModel {
  PokedexRegionRepo repo;

  PokemonRegionViewModel({this.repo});

  List<PokeRegions> regions = [];


  void getPokemonRegions() {
    setLoadingState(LoadingState.LOADING);
    repo.getPokemonRegions().then((value) {
      if (value != null) {
        regions.clear();
        regions.addAll(value);
      }
      setLoadingState(LoadingState.SUCCESS);
    }, onError: (e) {
      setLoadingState(LoadingState.FAIL);
    });
  }

  Future<List<Pokedexes>> getPokeDexList(
      {bool isForceRefresh = false, String url}) async {
    List<Pokedexes> pokeDexList = [];
    try {
      PokeRegionDetailResponse value = await repo.getPokemonRegionDetails(
          url: url, isForceRefresh: isForceRefresh);

      if (value != null) {
        value.pokedexes.forEach((pokeDex) {
          pokeDexList.add(pokeDex);
        });
      }
    } catch (e) {
      print(e);
    }
    return Future.value(pokeDexList);
  }
}
