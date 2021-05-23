import 'package:mypokedex/data_source/cache_manager.dart';
import 'package:mypokedex/pokedex/model/response/pokemon_details.dart';
import 'package:sembast/sembast.dart';

class PokemonDao {
  PokemonDao._privateConstructor();

  static final PokemonDao _instance = PokemonDao._privateConstructor();

  static PokemonDao get instance {
    _pokemonTable =
        intMapStoreFactory.store(CacheManager.instance.pokemonDetails);
    return _instance;
  }

  static StoreRef<int, Map<String, dynamic>> _pokemonTable;

  Future<Database> get _db async => await CacheManager.instance.database;

  Future insert(PokemonDetails pokemon) async {
    return await _pokemonTable
        .record(pokemon.id)
        .put(await _db, pokemon.toJson(), merge: true);
  }

  Future insertPokemonList(List<PokemonDetails> pokemonList) async {
    List<PokemonDetails> existingPokemon = await getPokemonSpeciesDetails();
    await _pokemonTable.delete(await _db);

    List<Map<String, dynamic>> pokemons = [];
    List<int> keys = [];
    pokemonList.forEach((pokemon) {
      existingPokemon.forEach((cachedPokemon) {
        if (pokemon.id == cachedPokemon.id) {
          pokemon.isFav =
              cachedPokemon.isFav == null ? false : cachedPokemon.isFav;
        }
      });
      pokemons.add(pokemon.toJson());
      keys.add(pokemon.id);
    });
    return await _pokemonTable
        .records(keys)
        .put(await _db, pokemons, merge: true);
  }

  Future<int> getPokemonSpeciesCount() async {
    return _pokemonTable.count(await _db);
  }

  Future update(PokemonDetails data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTable.update(
      await _db,
      data.toJson(),
      finder: finder,
    );
  }

  Future delete(PokemonDetails data) async {
    final finder = Finder(filter: Filter.byKey(data.id));
    return await _pokemonTable.delete(
      await _db,
      finder: finder,
    );
  }

  // ignore: non_constant_identifier_names
  Future<PokemonDetails> getPokemonById({int pokemonId}) async {
    final finder = Finder(filter: Filter.equals('id', pokemonId));
    final recordSnapshot =
        await _pokemonTable.findFirst(await _db, finder: finder);
    if (recordSnapshot != null) {
      final detail = PokemonDetails.fromJson(recordSnapshot.value);
      return detail;
    } else {
      return Future.value(null);
    }
  }

  Future<List<PokemonDetails>> getPokemonSpeciesDetails() async {
    final finder = Finder();
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);

    return recordSnapshot.map((snapshot) {
      final details = PokemonDetails.fromJson(snapshot.value);
      details.id = snapshot.key;
      return details;
    }).toList();
  }

  Future<List<PokemonDetails>> getFavPokemonSpeciesList() async {
    final finder = Finder(filter: Filter.equals('isFav', true));
    final recordSnapshot = await _pokemonTable.find(await _db, finder: finder);

    return recordSnapshot.map((snapshot) {
      final details = PokemonDetails.fromJson(snapshot.value);
      details.id = snapshot.key;
      return details;
    }).toList();
  }

  Future<Stream<List<RecordSnapshot<int, Map<String, dynamic>>>>>
      listenPokemonSpeciesDetails() async {
    final finder = Finder(filter: Filter.equals('isFav', true));
    var query = _pokemonTable.query(finder: finder);
    var subscription = query.onSnapshots(await _db);
    return subscription;
  }
}
