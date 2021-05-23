import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';

class PokedexDetailResponse {
  List<Descriptions> descriptions;
  int id;
  bool isMainSeries;
  String name;
  List<Names> names;
  List<PokemonEntries> pokemonEntries;
  Language region;
  List<VersionGroups> versionGroups;

  PokedexDetailResponse(
      {this.descriptions,
      this.id,
      this.isMainSeries,
      this.name,
      this.names,
      this.pokemonEntries,
      this.region,
      this.versionGroups});

  PokedexDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['descriptions'] != null) {
      descriptions = [];
      json['descriptions'].forEach((v) {
        descriptions.add(new Descriptions.fromJson(v));
      });
    }
    id = json['id'];
    isMainSeries = json['is_main_series'];
    name = json['name'];
    if (json['names'] != null) {
      names = [];
      json['names'].forEach((v) {
        names.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon_entries'] != null) {
      pokemonEntries = [];
      json['pokemon_entries'].forEach((v) {
        pokemonEntries.add(new PokemonEntries.fromJson(v));
      });
    }
    region =
        json['region'] != null ? new Language.fromJson(json['region']) : null;
    if (json['version_groups'] != null) {
      versionGroups = [];
      json['version_groups'].forEach((v) {
        versionGroups.add(new VersionGroups.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.descriptions != null) {
      data['descriptions'] = this.descriptions.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['is_main_series'] = this.isMainSeries;
    data['name'] = this.name;
    if (this.names != null) {
      data['names'] = this.names.map((v) => v.toJson()).toList();
    }
    if (this.pokemonEntries != null) {
      data['pokemon_entries'] =
          this.pokemonEntries.map((v) => v.toJson()).toList();
    }
    if (this.region != null) {
      data['region'] = this.region.toJson();
    }
    if (this.versionGroups != null) {
      data['version_groups'] =
          this.versionGroups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Descriptions {
  String description;
  Language language;

  Descriptions({this.description, this.language});

  Descriptions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    return data;
  }
}

class Language {
  String name;
  String url;

  Language({this.name, this.url});

  Language.fromJson(Map<String, dynamic> json) {
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

class Names {
  Language language;
  String name;

  Names({this.language, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
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

class PokemonEntries {
  int entryNumber;
  Result pokemonSpecies;

  PokemonEntries({this.entryNumber, this.pokemonSpecies});

  PokemonEntries.fromJson(Map<String, dynamic> json) {
    entryNumber = json['entry_number'];
    pokemonSpecies = json['pokemon_species'] != null
        ? new Result.fromJson(json['pokemon_species'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_number'] = this.entryNumber;
    if (this.pokemonSpecies != null) {
      data['pokemon_species'] = this.pokemonSpecies.toJson();
    }
    return data;
  }
}

class VersionGroups {
  String name;
  String url;

  VersionGroups({this.name, this.url});

  VersionGroups.fromJson(Map<String, dynamic> json) {
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
