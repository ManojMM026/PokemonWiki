import 'package:mypokedex/api/api.dart';
import 'package:dio/dio.dart';
import 'package:mypokedex/pokedex/dao/regions_dao.dart';
import 'package:mypokedex/pokedex/dao/regions_detail_dao.dart';
import 'package:mypokedex/pokedex/model/response/poke_region_response.dart';
import 'package:mypokedex/pokedex/model/response/region_detail_response.dart';
import 'package:mypokedex/util/app_constants.dart';
import 'package:mypokedex/util/util.dart';

class PokedexRegionRepo {
  Api api;
  RegionDao regionDao;
  RegionDetailsDao regionDetailsDao;

  PokedexRegionRepo({
    this.api,
    this.regionDetailsDao,
    this.regionDao,
  });

  Future<List<PokeRegions>> getPokemonRegions(
      {bool isForceRefresh = false}) async {
    if (isForceRefresh) {
      RegionResponse response = await _requestRegions();
      return Future.value(response.results);
    } else {
      List<PokeRegions> types = await regionDao.getAllRegions();
      if (types == null || types.isEmpty) {
        RegionResponse response = await _requestRegions();
        types = response.results;
      }
      return Future.value(types);
    }
  }

  ///request pokemon regions
  Future<RegionResponse> _requestRegions() async {
    Response response = await api.get(endPoint: AppConstants.pokemonRegions);
    if (response != null && response.data != null) {
      RegionResponse details = RegionResponse.fromJson(response.data);
      // await speciesDao.insert(details);
      await regionDao.insertRegionList(details.results);
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }

  Future<PokeRegionDetailResponse> getPokemonRegionDetails(
      {bool isForceRefresh = false, String url}) async {
    if (isForceRefresh) {
      PokeRegionDetailResponse response = await _requestRegionDetails(url: url);
      return Future.value(response);
    } else {
      String id = extractRegionId(url);
      PokeRegionDetailResponse region =
          await regionDetailsDao.getRegionDetailById(id: int.tryParse(id));
      if (region == null) {
        region = await _requestRegionDetails(url: url);
      }
      return Future.value(region);
    }
  }

  ///request pokemon regions
  Future<PokeRegionDetailResponse> _requestRegionDetails({String url}) async {
    Response response = await api.get(endPoint: url);
    if (response != null && response.data != null) {
      PokeRegionDetailResponse details =
          PokeRegionDetailResponse.fromJson(response.data);
      // await speciesDao.insert(details);
      await regionDetailsDao.insert(details);
      return Future.value(details);
    } else {
      return Future.error('No Data');
    }
  }
}
