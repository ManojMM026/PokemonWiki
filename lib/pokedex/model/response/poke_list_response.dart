class PokemonList {
  int count;
  String next;
  String previous;
  List<Result> results;

  PokemonList({this.count, this.next, this.previous, this.results});

  factory PokemonList.fromJson(Map<String, dynamic> json) {
    return PokemonList(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: json['results'] != null
          ? (json['results'] as List).map((i) => Result.fromJson(i)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    if (this.previous != null) {
      data['previous'] = this.previous;
    }
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int id;
  String name;
  String url;
  bool isFav;

  Result({this.name, this.url, this.id,this.isFav});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json['name'],
      id: json['id'],
      isFav: json['isFav'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['isFav'] = this.isFav;
    data['id'] = this.id;
    return data;
  }
}
