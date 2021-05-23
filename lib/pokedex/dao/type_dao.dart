import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:sembast/sembast.dart';
class TypeDao {
  TypeDao._privateConstructor();

  static final TypeDao _instance = TypeDao._privateConstructor();

  static TypeDao get instance {
    _pokemonTypeTable =
        stringMapStoreFactory.store(CacheManager.instance.pokemonType);
    return _instance;
  }

  static StoreRef<String, Map<String, dynamic>> _pokemonTypeTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(TypeX type) async {
    return await _pokemonTypeTable
        .record(type.name)
        .put(await _db, type.toJson(), merge: true);
  }

  Future insertPokemonList(List<TypeX> typeList) async {
    List<Map<String, dynamic>> species =[];
    List<String> keys =[];
    typeList.forEach((pokemon) {
      species.add(pokemon.toJson());
      keys.add(pokemon.name);
    });
    return await _pokemonTypeTable
        .records(keys)
        .put(await _db, species, merge: true);
  }

  Future<int> getTypeCount() async {
    return _pokemonTypeTable.count(await _db);
  }

  Future update(TypeX data) async {
    final finder = Finder(filter: Filter.byKey(data.name));
    return await _pokemonTypeTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(TypeX data) async {
    final finder = Finder(filter: Filter.byKey(data.name));
    return await _pokemonTypeTable.delete(
      await _db,
      finder: finder,
    );
  }

 

  Future<List<TypeX>> getAllTypes() async {
    final finder = Finder();
    final recordSnapshot = await _pokemonTypeTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final species = TypeX.fromJson(snapshot.value);
      species.name = snapshot.key;
      print('Type found :${species.toJson()}');
      return species;
    }).toList();
  }
}