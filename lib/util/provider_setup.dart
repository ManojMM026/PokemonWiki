import 'package:mypokedex/api/api.dart';
import 'package:mypokedex/main.dart';
import 'package:mypokedex/pokedex/dao/evolution_dao.dart';
import 'package:mypokedex/pokedex/dao/poke_by_type_dao.dart';
import 'package:mypokedex/pokedex/dao/poke_list_dao.dart';
import 'package:mypokedex/pokedex/dao/pokedex_detail_dao.dart';
import 'package:mypokedex/pokedex/dao/pokemon_dao.dart';
import 'package:mypokedex/pokedex/dao/regions_dao.dart';
import 'package:mypokedex/pokedex/dao/regions_detail_dao.dart';
import 'package:mypokedex/pokedex/dao/species_dao.dart';
import 'package:mypokedex/pokedex/dao/type_dao.dart';
import 'package:mypokedex/pokedex/presentation/screens/home/repo/pokedex_repo.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/repo/pokedex_region_repo.dart';
import 'package:mypokedex/pokedex/presentation/screens/types/repo/pokedex_type_repo.dart';
import 'package:mypokedex/pokedex/presentation/screens/regions/repo/region_dex_repo.dart';
import 'package:mypokedex/util/add_helper.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependantServices,
  ...uiConsumableProviders,
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: Api()),
  Provider.value(value: AdHelper(initGoogleMobileAds())),
  Provider.value(value: PokeListDao.instance),
  Provider.value(value: PokemonDao.instance),
  Provider.value(value: SpeciesDao.instance),
  Provider.value(value: EvolutionDao.instance),
  Provider.value(value: TypeDao.instance),
  Provider.value(value: RegionDao.instance),
  Provider.value(value: PokemonByTypeDao.instance),
  Provider.value(value: RegionDetailsDao.instance),
  Provider.value(value: PokedexDetailDao.instance),
];

List<SingleChildWidget> dependantServices = [
  ProxyProvider5<Api, PokeListDao, PokemonDao, SpeciesDao, EvolutionDao,
      PokedexRepo>(
    update: (context, api, pokeListDao, pokemonDao, speciesDao, evolutionDao,
            repo) =>
        PokedexRepo(
            api: api,
            pokeListDao: pokeListDao,
            evolutionDao: evolutionDao,
            pokemonDao: pokemonDao,
            speciesDao: speciesDao),
  ),
  ProxyProvider3<Api, RegionDao, RegionDetailsDao, PokedexRegionRepo>(
    update: (context, api, dao, detailDao, repo) => PokedexRegionRepo(
      api: api,
      regionDao: dao,
      regionDetailsDao: detailDao,
    ),
  ),
  ProxyProvider4<Api, TypeDao, PokeListDao, PokemonByTypeDao, PokedexTypeRepo>(
    update: (context, api, dao, pokeListDao, pokeTypeDao, repo) =>
        PokedexTypeRepo(
      api: api,
      pokeTypeDao: pokeTypeDao,
      typeDao: dao,
      pokeListDao: pokeListDao,
    ),
  ),
  ProxyProvider3<Api, PokedexDetailDao, PokeListDao, RegionDexRepo>(
    update: (context, api, dao, listDao, repo) =>
        RegionDexRepo(api: api, detailDao: dao, pokeListDao: listDao),
  )
];
List<SingleChildWidget> uiConsumableProviders = [
  /*StreamProvider<List<Device>>(
    create: (context) =>
    Provider.of<DeviceRepo>(context, listen: false).deviceListResponse,
  ),*/
];
