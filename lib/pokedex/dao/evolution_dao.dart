import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_evolutions_response.dart';
import 'package:sembast/sembast.dart';
class EvolutionDao {
  EvolutionDao._privateConstructor();

  static final EvolutionDao _instance = EvolutionDao._privateConstructor();

  static EvolutionDao get instance {
    _pokemonTable =
        stringMapStoreFactory.store(CacheManager.instance.pokemonEvolution);
    return _instance;
  }

  static StoreRef<String, Map<String, dynamic>> _pokemonTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokemonEvolution pokemon) async {
    return await _pokemonTable
        .record(pokemon.evolutionChain)
        .put(await _db, pokemon.toJson(), merge: true);
  }

  Future insertPokemonList(List<PokemonEvolution> pokemonList) async {
    List<Map<String, dynamic>> species =[];
    List<String> keys =[];
    pokemonList.forEach((pokemon) {
      species.add(pokemon.toJson());
      keys.add(pokemon.evolutionChain);
    });
    return await _pokemonTable
        .records(keys)
        .put(await _db, species, merge: true);
  }

  Future<int> getPokemonCount() async {
    return _pokemonTable.count(await _db);
  }

  Future update(PokemonEvolution data) async {
    final finder = Finder(filter: Filter.byKey(data.evolutionChain));
    return await _pokemonTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokemonEvolution data) async {
    final finder = Finder(filter: Filter.byKey(data.evolutionChain));
    return await _pokemonTable.delete(
      await _db,
      finder: finder,
    );
  }

  // ignore: non_constant_identifier_names
  Future<PokemonEvolution> getPokemonByEvolutionChain({String url}) async {
    print('Get Pokemon by $url');
    await getAllPokemonEvolutionChains();
    final finder = Finder(filter: Filter.equals('evolutionChain', url));
    final recordSnapshot =
    await _pokemonTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final species = PokemonEvolution.fromJson(recordSnapshot.value);
      return species;
    } else {
      return Future.value(null);
    }
  }

  Future<List<PokemonEvolution>> getAllPokemonEvolutionChains() async {
    final finder = Finder();
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);
    return recordSnapshot.map((snapshot) {
      final species = PokemonEvolution.fromJson(snapshot.value);
      species.evolutionChain = snapshot.key;
      print('Evolution found :${species.toJson()}');
      return species;
    }).toList();
  }
}