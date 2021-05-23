import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/poke_list_response.dart';
import 'package:mypokedex/util/util.dart';
import 'package:sembast/sembast.dart';

class PokeListDao {
  PokeListDao._privateConstructor();

  static final PokeListDao _instance = PokeListDao._privateConstructor();

  static PokeListDao get instance {
    _pokemonTable = intMapStoreFactory.store(CacheManager.instance.pokemonList);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _pokemonTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(Result pokemon) async {
    return await _pokemonTable
        .record(int.tryParse(extractPokemonId(pokemon.url)))
        .put(await _db, pokemon.toJson(), merge: true);
  }

  Future insertPokemonList(List<Result> pokemonList) async {
    List<Map<String, dynamic>> pokemons = [];
    List<int> keys = [];
    pokemonList.forEach((pokemon) {
      pokemons.add(pokemon.toJson());
      keys.add(int.tryParse(extractPokemonId(pokemon.url)));
      print('Pokemon---: ${pokemon.name} ${pokemon.url}');
    });
    return await _pokemonTable
        .records(keys)
        .put(await _db, pokemons, merge: true);
  }

  Future<int> getPokemonCount() async {
    return _pokemonTable.count(await _db);
  }

  Future update(Result data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(Result data) async {
    final finder = Finder(filter: Filter.byKey(data.url));
    return await _pokemonTable.delete(
      await _db,
      finder: finder,
    );
  }

  // ignore: non_constant_identifier_names
  Future<Result> getPokemonByUrl({String pokemonUrl}) async {
    final finder = Finder(filter: Filter.equals('url', pokemonUrl));
    final recordSnapshot =
        await _pokemonTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final pokemon = Result.fromJson(recordSnapshot.value);
      pokemon.id = recordSnapshot.key;
      return pokemon;
    } else {
      return Future.value(null);
    }
  }

  Future<Result> getPokemonById({int id}) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _pokemonTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final pokemon = Result.fromJson(recordSnapshot.value);
      return pokemon;
    } else {
      return Future.value(null);
    }
  }

  Future<List<Result>> getAllPokemons() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key, true)]);
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);

    return recordSnapshot.map((snapshot) {
      final pokemon = Result.fromJson(snapshot.value);
      pokemon.id = snapshot.key;
      return pokemon;
    }).toList();
  }

  Future<List<Result>> getAllFavPokemons() async {
    final finder = Finder(filter: Filter.equals('isFav', true));
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);

    return recordSnapshot.map((snapshot) {
      final pokemon = Result.fromJson(snapshot.value);
      pokemon.id = snapshot.key;
      return pokemon;
    }).toList();
  }
}
