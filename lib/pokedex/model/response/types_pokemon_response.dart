import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';

class TypesPokemonResponse {
  DamageRelations damageRelations;
  List<GameIndices> gameIndices;
  DoubleDamageFrom generation;
  int id;
  DoubleDamageFrom moveDamageClass;
  List<Moves> moves;
  String name;
  List<Names> names;
  List<Pokemon> pokemon;

  TypesPokemonResponse(
      {this.damageRelations,
      this.gameIndices,
      this.generation,
      this.id,
      this.moveDamageClass,
      this.moves,
      this.name,
      this.names,
      this.pokemon});

  TypesPokemonResponse.fromJson(Map<String, dynamic> json) {
    damageRelations = json['damage_relations'] != null
        ? new DamageRelations.fromJson(json['damage_relations'])
        : null;
    if (json['game_indices'] != null) {
      gameIndices = [];
      json['game_indices'].forEach((v) {
        gameIndices.add(new GameIndices.fromJson(v));
      });
    }
    generation = json['generation'] != null
        ? new DoubleDamageFrom.fromJson(json['generation'])
        : null;
    id = json['id'];
    moveDamageClass = json['move_damage_class'] != null
        ? new DoubleDamageFrom.fromJson(json['move_damage_class'])
        : null;
    if (json['moves'] != null) {
      moves = [];
      json['moves'].forEach((v) {
        moves.add(new Moves.fromJson(v));
      });
    }
    name = json['name'];
    if (json['names'] != null) {
      names = [];
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon'] != null) {
      pokemon = [];
      json['pokemon'].forEach((v) {
       /* print(
            'V : ${v.toString()} ${new Result.fromJson(v).name} ${new Result.fromJson(v).url}');*/
        pokemon.add(new Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.damageRelations != null) {
      data['damage_relations'] = this.damageRelations.toJson();
    }
    if (this.gameIndices != null) {
      data['game_indices'] = this.gameIndices.map((v) => v.toJson()).toList();
    }
    if (this.generation != null) {
      data['generation'] = this.generation.toJson();
    }
    data['id'] = this.id;
    if (this.moveDamageClass != null) {
      data['move_damage_class'] = this.moveDamageClass.toJson();
    }
    if (this.moves != null) {
      data['moves'] = this.moves.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DamageRelations {
  List<DoubleDamageFrom> doubleDamageFrom;
  List<DoubleDamageTo> doubleDamageTo;
  List<HalfDamageFrom> halfDamageFrom;
  List<HalfDamageTo> halfDamageTo;
  List<NoDamageFrom> noDamageFrom;
  List<NoDamageTo> noDamageTo;

  DamageRelations(
      {this.doubleDamageFrom,
      this.doubleDamageTo,
      this.halfDamageFrom,
      this.halfDamageTo,
      this.noDamageFrom,
      this.noDamageTo});

  DamageRelations.fromJson(Map<String, dynamic> json) {
    if (json['double_damage_from'] != null) {
      doubleDamageFrom = [];
      json['double_damage_from'].forEach((v) {
        doubleDamageFrom.add(new DoubleDamageFrom.fromJson(v));
      });
    }
    if (json['double_damage_to'] != null) {
      doubleDamageTo = [];
      json['double_damage_to'].forEach((v) {
        doubleDamageTo.add(new DoubleDamageTo.fromJson(v));
      });
    }
    if (json['half_damage_from'] != null) {
      halfDamageFrom = [];
      json['half_damage_from'].forEach((v) {
        halfDamageFrom.add(new HalfDamageFrom.fromJson(v));
      });
    }
    if (json['half_damage_to'] != null) {
      halfDamageTo = [];
      json['half_damage_to'].forEach((v) {
        halfDamageTo.add(new HalfDamageTo.fromJson(v));
      });
    }
    if (json['no_damage_from'] != null) {
      noDamageFrom = [];
      json['no_damage_from'].forEach((v) {
        noDamageFrom.add(new NoDamageFrom.fromJson(v));
      });
    }
    if (json['no_damage_to'] != null) {
      noDamageTo = [];
      json['no_damage_to'].forEach((v) {
        noDamageTo.add(new NoDamageTo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doubleDamageFrom != null) {
      data['double_damage_from'] =
          this.doubleDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.doubleDamageTo != null) {
      data['double_damage_to'] =
          this.doubleDamageTo.map((v) => v.toJson()).toList();
    }
    if (this.halfDamageFrom != null) {
      data['half_damage_from'] =
          this.halfDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.halfDamageTo != null) {
      data['half_damage_to'] =
          this.halfDamageTo.map((v) => v.toJson()).toList();
    }
    if (this.noDamageFrom != null) {
      data['no_damage_from'] =
          this.noDamageFrom.map((v) => v.toJson()).toList();
    }
    if (this.noDamageTo != null) {
      data['no_damage_to'] = this.noDamageTo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoubleDamageFrom {
  String name;
  String url;

  DoubleDamageFrom({this.name, this.url});

  DoubleDamageFrom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Pokemon {
  Result pokemon;
  int slot;

  Pokemon({this.pokemon, this.slot});

  Pokemon.fromJson(Map<String, dynamic> json) {
    pokemon =
    json['pokemon'] != null ? new Result.fromJson(json['pokemon']) : null;
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pokemon != null) {
      data['pokemon'] = this.pokemon.toJson();
    }
    data['slot'] = this.slot;
    return data;
  }
}





class DoubleDamageTo {
  String name;
  String url;

  DoubleDamageTo({this.name, this.url});

  DoubleDamageTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class HalfDamageFrom {
  String name;
  String url;

  HalfDamageFrom({this.name, this.url});

  HalfDamageFrom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class HalfDamageTo {
  String name;
  String url;

  HalfDamageTo({this.name, this.url});

  HalfDamageTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class NoDamageFrom {
  String name;
  String url;

  NoDamageFrom({this.name, this.url});

  NoDamageFrom.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class NoDamageTo {
  String name;
  String url;

  NoDamageTo({this.name, this.url});

  NoDamageTo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Moves {
  String name;
  String url;

  Moves({this.name, this.url});

  Moves.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class GameIndices {
  int gameIndex;
  DoubleDamageFrom generation;

  GameIndices({this.gameIndex, this.generation});

  GameIndices.fromJson(Map<String, dynamic> json) {
    gameIndex = json['game_index'];
    generation = json['generation'] != null
        ? new DoubleDamageFrom.fromJson(json['generation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_index'] = this.gameIndex;
    if (this.generation != null) {
      data['generation'] = this.generation.toJson();
    }
    return data;
  }
}

class Names {
  DoubleDamageFrom language;
  String name;

  Names({this.language, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new DoubleDamageFrom.fromJson(json['language'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}
