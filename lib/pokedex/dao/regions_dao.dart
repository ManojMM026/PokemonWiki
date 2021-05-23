import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/poke_region_response.dart';
import 'package:sembast/sembast.dart';

class RegionDao {
  RegionDao._privateConstructor();

  static final RegionDao _instance = RegionDao._privateConstructor();

  static RegionDao get instance {
    _pokemonTypeTable =
        stringMapStoreFactory.store(CacheManager.instance.pokemonRegion);
    return _instance;
  }

  static StoreRef<String, Map<String, dynamic>> _pokemonTypeTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokeRegions type) async {
    return await _pokemonTypeTable
        .record(type.name)
        .put(await _db, type.toJson(), merge: true);
  }

  Future insertRegionList(List<PokeRegions> regionList) async {
    List<Map<String, dynamic>> regions = [];
    List<String> keys = [];
    regionList.forEach((pokemon) {
      regions.add(pokemon.toJson());
      keys.add(pokemon.name);
    });
    return await _pokemonTypeTable
        .records(keys)
        .put(await _db, regions, merge: true);
  }

  Future<int> getRegionCount() async {
    return _pokemonTypeTable.count(await _db);
  }

  Future update(PokeRegions data) async {
    final finder = Finder(filter: Filter.byKey(data.name));
    return await _pokemonTypeTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokeRegions data) async {
    final finder = Finder(filter: Filter.byKey(data.name));
    return await _pokemonTypeTable.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<PokeRegions>> getAllRegions() async {
    final finder = Finder();
    final recordSnapshot =
        await _pokemonTypeTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final species = PokeRegions.fromJson(snapshot.value);
      species.name = snapshot.key;
      print('Region found :${species.toJson()}');
      return species;
    }).toList();
  }
}
