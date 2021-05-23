import 'package:mypokedex/core/base_view_model.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/repo/pokedex_type_repo.dart';
import 'package:mypokedex/util/app_constants.dart';

class PokemonTypesViewModel extends BaseViewModel {
  PokedexTypeRepo repo;

  PokemonTypesViewModel({this.repo});

  List<TypeX> pokemonTypes = [];

  void getPokemonTypes() {
    setLoadingState(LoadingState.LOADING);
    repo.getPokemonTypes().then((value) {
      if (value != null) {
        pokemonTypes.addAll(value);
      }
      setLoadingState(LoadingState.SUCCESS);
    }, onError: (e) {
      setLoadingState(LoadingState.FAIL);
    });
  }
}
