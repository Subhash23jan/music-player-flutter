import 'package:flutter/foundation.dart';
import 'package:music_player_demo/Sqlfite/sql_tables.dart';
import 'package:music_player_demo/models/favourites_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'MyMusic.db');
      return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(Tables().userTable);
          db.execute(Tables().recentListenedTable);
          db.execute(Tables().playListsTable);
          db.execute(Tables().customPlaylists);
          db.execute(Tables().favouriteSongsTable);
        },
      );
    } catch (e) {
      print('Error initializing database: $e');
      rethrow; // Rethrow the exception for debugging purposes
    }
  }

  Future<List<SongModel>> getFavourites() async {
    try {
      Database db = await getDatabase();
      List<Map<String, Object?>>? maps = await db.query('favouriteSongs');
      return List.generate(maps.length, (index) => SongModel(maps[index]));
    } catch (e) {
      print('Error getting favourites: $e');
      return []; // Return an empty list or handle the error according to your needs
    }
  }
  Future<void>addFavourites(Favourites songModel)async{
    Database db = await getDatabase();
    db.insert('favouriteSongs',songModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<List<SongModel>> getRecent() async {
    try {
      Database db = await getDatabase();
      List<Map<String, Object?>>? maps = await db.query('recentListened');
      return List.generate(maps.length, (index) => SongModel(maps[index]));
    } catch (e) {
      print('Error getting favourites: $e');
      return []; // Return an empty list or handle the error according to your needs
    }
  }
  Future<void>addToRecent(Favourites songModel)async{
    Database db = await getDatabase();
    int? id=songModel.getMap['_id'];
    if (kDebugMode) {
      print(id);
    }
    try {
      if(id!=null) {
        db.execute('''
    DELETE FROM recentListened WHERE _id = $id;
  ''');
      }
      if (kDebugMode) {
        print("deleted");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting row: $e');
      }
    }
    db.insert('recentListened',songModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

// Example usage:
void main() async {
  try {
    DataBaseHelper dbHelper = DataBaseHelper();
    List<SongModel> favourites = await dbHelper.getFavourites();
    print('Favourite songs: $favourites');
  } catch (e) {
    print('An error occurred: $e');
  }
}
