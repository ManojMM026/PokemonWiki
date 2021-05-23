import 'dart:async';
import 'package:mypokedex/util/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

///Class contains app database configuration.
///Table name configs.
///Opening database connection.
class CacheManager {
  CacheManager._privateConstructor();

  static final CacheManager _instance = CacheManager._privateConstructor();

  static CacheManager get instance {
    return _instance;
  }

  ///Table names
  String _pokemonList = "PokemonList";
  String _pokemonDetails = "PokemonDetails";
  String _pokemonSpecies = "PokemonSpecies";
  String _pokemonEvolution = "PokemonEvolution";
  String _pokemonType = "PokemonType";
  String _pokemonByType = "PokemonByType";
  String _pokemonRegion = "PokemonRegion";
  String _pokemonRegionDetail = "PokemonRegionDetail";
  String _pokeDexDetail = "PokedexDetail";

  String get pokemonList => _pokemonList;

  String get pokemonDetails => _pokemonDetails;
  Completer<Database> dbOpenCompleter;

  ///Open no-sql database connection.
  Future<Database> get database async {
    if (dbOpenCompleter == null) {
      dbOpenCompleter = Completer();
      _openDatabase();
    }
    return dbOpenCompleter.future;
  }

  ///Open database connection.
  ///create database on storage and return db instance.
  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, AppConstants.DB);

    final database = await databaseFactoryIo
        .openDatabase(dbPath, version: AppConstants.DB_VERSION,
            onVersionChanged: (db, oldVersion, newVersion) async {
      if (oldVersion != newVersion) {}
    });
    dbOpenCompleter.complete(database);
  }

  String get pokemonSpecies => _pokemonSpecies;

  String get pokemonEvolution => _pokemonEvolution;

  String get pokemonType => _pokemonType;

  String get pokemonRegion => _pokemonRegion;

  String get pokemonByType => _pokemonByType;

  String get pokemonRegionDetail => _pokemonRegionDetail;

  String get pokeDexDetail => _pokeDexDetail;
}
