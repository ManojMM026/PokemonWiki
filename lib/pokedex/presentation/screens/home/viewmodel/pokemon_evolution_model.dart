import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_evolutions_response.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/repo/pokedex_repo.dart';

class PokemonEvolutionViewModel extends ChangeNotifier {
  PokedexRepo repo;
  PokemonEvolution details;

  PokemonEvolutionViewModel({@required this.repo});

  void getEvolution({@required String url}) async {
    details = await repo.getPokemonEvolution(url: url);
    notifyListeners();
  }
}
