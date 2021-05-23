import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';

class Pokemon {
  PokemonDetails details;
  PokemonSpeciesDetails speciesDetails;

  Pokemon({this.details, this.speciesDetails});
}

class PokemonDetails {
  List<Ability> abilities;
  // ignore: non_constant_identifier_names
  int base_experience;
  List<Form> forms;
  // ignore: non_constant_identifier_names
  List<GameIndice> game_indices;
  int height;
  int id;
  // ignore: non_constant_identifier_names
  bool is_default;
  // ignore: non_constant_identifier_names
  String location_area_encounters;
  List<Move> moves;
  String name;
  int order;
  Species species;
  List<Stat> stats;
  List<Type> types;
  int weight;
  bool isFav;

  PokemonDetails(
      {this.abilities,
      // ignore: non_constant_identifier_names
      this.base_experience,
      this.forms,
      // ignore: non_constant_identifier_names
      this.game_indices,
      this.height,
      this.isFav,
      this.id,
      // ignore: non_constant_identifier_names
      this.is_default,
      // ignore: non_constant_identifier_names
      this.location_area_encounters,
      this.moves,
      this.name,
      this.order,
      this.species,
      this.stats,
      this.types,
      this.weight});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    return PokemonDetails(
      abilities: json['abilities'] != null
          ? (json['abilities'] as List).map((i) => Ability.fromJson(i)).toList()
          : null,
      base_experience: json['base_experience'],
      forms: json['forms'] != null
          ? (json['forms'] as List).map((i) => Form.fromJson(i)).toList()
          : null,
      game_indices: json['game_indices'] != null
          ? (json['game_indices'] as List)
              .map((i) => GameIndice.fromJson(i))
              .toList()
          : null,
      height: json['height'],
      id: json['id'],
      is_default: json['is_default'],
      location_area_encounters: json['location_area_encounters'],
      moves: json['moves'] != null
          ? (json['moves'] as List).map((i) => Move.fromJson(i)).toList()
          : null,
      name: json['name'],
      isFav: json['isFav'],
      order: json['order'],
      species:
          json['species'] != null ? Species.fromJson(json['species']) : null,
      stats: json['stats'] != null
          ? (json['stats'] as List).map((i) => Stat.fromJson(i)).toList()
          : null,
      types: json['types'] != null
          ? (json['types'] as List).map((i) => Type.fromJson(i)).toList()
          : null,
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_experience'] = this.base_experience;
    data['height'] = this.height;
    data['id'] = this.id;
    data['isFav'] = this.isFav;
    data['is_default'] = this.is_default;
    data['location_area_encounters'] = this.location_area_encounters;
    data['name'] = this.name;
    data['order'] = this.order;
    data['weight'] = this.weight;
    if (this.abilities != null) {
      data['abilities'] = this.abilities.map((v) => v.toJson()).toList();
    }
    if (this.forms != null) {
      data['forms'] = this.forms.map((v) => v.toJson()).toList();
    }
    if (this.game_indices != null) {
      data['game_indices'] = this.game_indices.map((v) => v.toJson()).toList();
    }

    if (this.moves != null) {
      data['moves'] = this.moves.map((v) => v.toJson()).toList();
    }
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.map((v) => v.toJson()).toList();
    }
    if (this.types != null) {
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stat {
  // ignore: non_constant_identifier_names
  int base_stat;
  int effort;
  StatX stat;

  // ignore: non_constant_identifier_names
  Stat({this.base_stat, this.effort, this.stat});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      base_stat: json['base_stat'],
      effort: json['effort'],
      stat: json['stat'] != null ? StatX.fromJson(json['stat']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_stat'] = this.base_stat;
    data['effort'] = this.effort;
    if (this.stat != null) {
      data['stat'] = this.stat.toJson();
    }
    return data;
  }
}

class StatX {
  String name;
  String url;

  StatX({this.name, this.url});

  factory StatX.fromJson(Map<String, dynamic> json) {
    return StatX(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Ability {
  AbilityX ability;
  // ignore: non_constant_identifier_names
  bool is_hidden;
  int slot;

  // ignore: non_constant_identifier_names
  Ability({this.ability, this.is_hidden, this.slot});

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      ability:
          json['ability'] != null ? AbilityX.fromJson(json['ability']) : null,
      is_hidden: json['is_hidden'],
      slot: json['slot'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_hidden'] = this.is_hidden;
    data['slot'] = this.slot;
    if (this.ability != null) {
      data['ability'] = this.ability.toJson();
    }
    return data;
  }
}

class AbilityX {
  String name;
  String url;

  AbilityX({this.name, this.url});

  factory AbilityX.fromJson(Map<String, dynamic> json) {
    return AbilityX(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class GameIndice {
  // ignore: non_constant_identifier_names
  int game_index;
  Version version;

  // ignore: non_constant_identifier_names
  GameIndice({this.game_index, this.version});

  factory GameIndice.fromJson(Map<String, dynamic> json) {
    return GameIndice(
      game_index: json['game_index'],
      version:
          json['version'] != null ? Version.fromJson(json['version']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_index'] = this.game_index;
    if (this.version != null) {
      data['version'] = this.version.toJson();
    }
    return data;
  }
}

class Version {
  String name;
  String url;

  Version({this.name, this.url});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Form {
  String name;
  String url;

  Form({this.name, this.url});

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Type {
  int slot;
  TypeX type;

  Type({this.slot, this.type});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slot: json['slot'],
      type: json['type'] != null ? TypeX.fromJson(json['type']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    return data;
  }
}
class PokemonTypeResponse {
  int count;
  int next;
  int previous;
  List<TypeX> results;

  PokemonTypeResponse({this.count, this.next, this.previous, this.results});

  PokemonTypeResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new TypeX.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




class TypeX {
  String name;
  String url;

  TypeX({this.name, this.url});

  factory TypeX.fromJson(Map<String, dynamic> json) {
    return TypeX(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Move {
  MoveX move;
  // ignore: non_constant_identifier_names
  List<VersionGroupDetail> version_group_details;

  // ignore: non_constant_identifier_names
  Move({this.move, this.version_group_details});

  factory Move.fromJson(Map<String, dynamic> json) {
    return Move(
      move: json['move'] != null ? MoveX.fromJson(json['move']) : null,
      version_group_details: json['version_group_details'] != null
          ? (json['version_group_details'] as List)
              .map((i) => VersionGroupDetail.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.move != null) {
      data['move'] = this.move.toJson();
    }
    if (this.version_group_details != null) {
      data['version_group_details'] =
          this.version_group_details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VersionGroupDetail {
  // ignore: non_constant_identifier_names
  int level_learned_at;
  // ignore: non_constant_identifier_names
  MoveLearnMethod move_learn_method;
  // ignore: non_constant_identifier_names
  VersionGroup version_group;

  VersionGroupDetail(
      // ignore: non_constant_identifier_names
      {this.level_learned_at, this.move_learn_method, this.version_group});

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) {
    return VersionGroupDetail(
      level_learned_at: json['level_learned_at'],
      move_learn_method: json['move_learn_method'] != null
          ? MoveLearnMethod.fromJson(json['move_learn_method'])
          : null,
      version_group: json['version_group'] != null
          ? VersionGroup.fromJson(json['version_group'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_learned_at'] = this.level_learned_at;
    if (this.move_learn_method != null) {
      data['move_learn_method'] = this.move_learn_method.toJson();
    }
    if (this.version_group != null) {
      data['version_group'] = this.version_group.toJson();
    }
    return data;
  }
}

class MoveLearnMethod {
  String name;
  String url;

  MoveLearnMethod({this.name, this.url});

  factory MoveLearnMethod.fromJson(Map<String, dynamic> json) {
    return MoveLearnMethod(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class VersionGroup {
  String name;
  String url;

  VersionGroup({this.name, this.url});

  factory VersionGroup.fromJson(Map<String, dynamic> json) {
    return VersionGroup(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class MoveX {
  String name;
  String url;

  MoveX({this.name, this.url});

  factory MoveX.fromJson(Map<String, dynamic> json) {
    return MoveX(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Species {
  String name;
  String url;

  Species({this.name, this.url});

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
