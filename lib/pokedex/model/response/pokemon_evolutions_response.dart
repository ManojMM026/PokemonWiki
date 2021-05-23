import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';

class PokemonEvolution {
  String evolutionChain;
  List<Species> species;

  PokemonEvolution({this.species, this.evolutionChain});

  factory PokemonEvolution.fromJson(Map<String, dynamic> json) {
    return PokemonEvolution(
      evolutionChain: json['evolutionChain'],
      species: json['species'] != null
          ? (json['species'] as List).map((i) => Species.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['evolutionChain'] = this.evolutionChain;
    if (this.species != null) {
      data['species'] = this.species.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
