import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_species_details.dart';
import 'package:sembast/sembast.dart';
class SpeciesDao {
  SpeciesDao._privateConstructor();

  static final SpeciesDao _instance = SpeciesDao._privateConstructor();

  static SpeciesDao get instance {
    _pokemonTable =
        intMapStoreFactory.store(CacheManager.instance.pokemonSpecies);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _pokemonTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokemonSpeciesDetails pokemon) async {
    return await _pokemonTable
        .record(pokemon.id)
        .put(await _db, pokemon.toJson(), merge: true);
  }

  Future insertPokemonList(List<PokemonSpeciesDetails> pokemonList) async {
    await _pokemonTable.delete(await _db);

    List<Map<String, dynamic>> species =[];
    List<int> keys =[];
    pokemonList.forEach((pokemon) {
      species.add(pokemon.toJson());
      keys.add(pokemon.id);
    });
    return await _pokemonTable
        .records(keys)
        .put(await _db, species, merge: true);
  }

  Future<int> getPokemonCount() async {
    return _pokemonTable.count(await _db);
  }

  Future update(PokemonSpeciesDetails data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokemonSpeciesDetails data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTable.delete(
      await _db,
      finder: finder,
    );
  }

  // ignore: non_constant_identifier_names
  Future<PokemonSpeciesDetails> getPokemonSpeciesById({int pokemonId}) async {
    final finder = Finder(filter: Filter.equals('id', pokemonId));
    final recordSnapshot =
    await _pokemonTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final species = PokemonSpeciesDetails.fromJson(recordSnapshot.value);
      return species;
    } else {
      return Future.value(null);
    }
  }

  Future<List<PokemonSpeciesDetails>> getPokemonDetails() async {
    final finder = Finder();
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);

    return recordSnapshot.map((snapshot) {
      final species = PokemonSpeciesDetails.fromJson(snapshot.value);
      species.id = snapshot.key;
      return species;
    }).toList();
  }
}