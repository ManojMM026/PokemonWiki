import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/pokedex_details_response.dart';
import 'package:sembast/sembast.dart';

class PokedexDetailDao {
  PokedexDetailDao._privateConstructor();

  static final PokedexDetailDao _instance =
      PokedexDetailDao._privateConstructor();

  static PokedexDetailDao get instance {
    _regionDetailsTable =
        intMapStoreFactory.store(CacheManager.instance.pokeDexDetail);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _regionDetailsTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokedexDetailResponse details) async {
    return await _regionDetailsTable
        .record(details.id)
        .put(await _db, details.toJson(), merge: true);
  }

  Future insertPokedexList(List<PokedexDetailResponse> detailsList) async {
    List<Map<String, dynamic>> species = [];
    List<int> keys = [];
    detailsList.forEach((pokemon) {
      species.add(pokemon.toJson());
      keys.add(pokemon.id);
    });
    return await _regionDetailsTable
        .records(keys)
        .put(await _db, species, merge: true);
  }

  Future<int> getPokedexCount() async {
    return _regionDetailsTable.count(await _db);
  }

  Future update(PokedexDetailResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _regionDetailsTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokedexDetailResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _regionDetailsTable.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<PokedexDetailResponse>> getAllPokedexDetails() async {
    final finder = Finder();
    final recordSnapshot =
        await _regionDetailsTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final detail = PokedexDetailResponse.fromJson(snapshot.value);
      detail.id = snapshot.key;
      print('Pokdex detail found :${detail.toJson()}');
      return detail;
    }).toList();
  }

  Future<PokedexDetailResponse> getPokedexDetailById({int id}) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _regionDetailsTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final detail = PokedexDetailResponse.fromJson(recordSnapshot.value);
      return detail;
    } else {
      return Future.value(null);
    }
  }
}
