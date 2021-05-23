import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/region_detail_response.dart';
import 'package:sembast/sembast.dart';

class RegionDetailsDao {
  RegionDetailsDao._privateConstructor();

  static final RegionDetailsDao _instance =
      RegionDetailsDao._privateConstructor();

  static RegionDetailsDao get instance {
    _regionDetailsTable =
        intMapStoreFactory.store(CacheManager.instance.pokemonRegionDetail);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _regionDetailsTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokeRegionDetailResponse details) async {
    return await _regionDetailsTable
        .record(details.id)
        .put(await _db, details.toJson(), merge: true);
  }

  Future insertRegionList(List<PokeRegionDetailResponse> detailsList) async {
    List<Map<String, dynamic>> regionList = [];
    List<int> keys = [];
    detailsList.forEach((pokemon) {
      regionList.add(pokemon.toJson());
      keys.add(pokemon.id);
    });
    return await _regionDetailsTable
        .records(keys)
        .put(await _db, regionList, merge: true);
  }

  Future<int> getRegionCount() async {
    return _regionDetailsTable.count(await _db);
  }

  Future update(PokeRegionDetailResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _regionDetailsTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokeRegionDetailResponse data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _regionDetailsTable.delete(
      await _db,
      finder: finder,
    );
  }

  Future<List<PokeRegionDetailResponse>> getAllRegionsDetails() async {
    final finder = Finder();
    final recordSnapshot =
        await _regionDetailsTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final detail = PokeRegionDetailResponse.fromJson(snapshot.value);
      detail.id = snapshot.key;
      print('Region detail found :${detail.toJson()}');
      return detail;
    }).toList();
  }

  Future<PokeRegionDetailResponse> getRegionDetailById({int id}) async {
    final finder = Finder(filter: Filter.equals('id', id));
    final recordSnapshot =
        await _regionDetailsTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final detail = PokeRegionDetailResponse.fromJson(recordSnapshot.value);
      return detail;
    } else {
      return Future.value(null);
    }
  }
}
