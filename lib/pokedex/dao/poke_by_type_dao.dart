import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/types_pokemon_response.dart';
import 'package:sembast/sembast.dart';

class PokemonByTypeDao {
  PokemonByTypeDao._privateConstructor();

  static final PokemonByTypeDao _instance =
      PokemonByTypeDao._privateConstructor();

  static PokemonByTypeDao get instance {
    _pokemonTypeTable =
        intMapStoreFactory.store(CacheManager.instance.pokemonByType);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _pokemonTypeTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(TypesPokemonResponse type) async {
    return await _pokemonTypeTable
        .record(type.id)
        .put(await _db, type.toJson(), merge: true);
  }

  Future insertPokemonList(List<TypesPokemonResponse> typeList) async {
    List<Map<String, dynamic>> species = [];
    List<int> keys = [];
    typeList.forEach((pokemon) {
      species.add(pokemon.toJson());
      keys.add(pokemon.id);
    });
    return await _pokemonTypeTable
        .records(keys)
        .put(await _db, species, merge: true);
  }

  Future<int> getTypeCount() async {
    return _pokemonTypeTable.count(await _db);
  }

  Future update(TypesPokemonResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTypeTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(TypesPokemonResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTypeTable.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<TypesPokemonResponse>> getAllTypes() async {
    final finder = Finder();
    final recordSnapshot =
        await _pokemonTypeTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final species = TypesPokemonResponse.fromJson(snapshot.value);
      species.id = snapshot.key;
      print('Type found :${species.toJson()}');
      return species;
    }).toList();
  }

  Future<TypesPokemonResponse> getPokemonByTypeId({int id}) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _pokemonTypeTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final pokemon = TypesPokemonResponse.fromJson(recordSnapshot.value);
      return pokemon;
    } else {
      return Future.value(null);
    }
  }

}
