import 'package:flutter/material.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/repo/pokedex_repo.dart';

class PokemonDetailsViewModel extends ChangeNotifier {
  PokedexRepo repo;
  Pokemon details;

  PokemonDetailsViewModel({@required this.repo});

  void getPokemonDetails({@required String url}) async {
    details = await repo.getPokemonDetails(url: url);
    notifyListeners();
  }
}
