import 'package:flutter/foundation.dart';
import 'package:music_player_demo/Sqlfite/sql_tables.dart';
import 'package:music_player_demo/models/favourites_model.dart';
import 'package:music_player_demo/models/recent_listens.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  static Database? _database;
  static final DataBaseHelper _instance = DataBaseHelper._internal();

  factory DataBaseHelper() {
    return _instance;
  }

  DataBaseHelper._internal();

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
    db.insert('favouriteSongs',songModel.toMap(),conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  Future<void> removeFromFavourites(int id) async {
    Database db = await getDatabase();
    await db.rawDelete(
      'DELETE FROM favouriteSongs WHERE _id = ?',
      [id],
    );
  }
  Future<List<RecentSong>> getRecent() async {
    try {
      Database db = await getDatabase();
      List<Map<String, Object?>>? maps = await db.query('recentListened',orderBy: 'dataId DESC');
      return List.generate(maps.length, (index) => RecentSong(maps[index]));
    } catch (e) {
      print('Error getting favourites: $e');
      return [];
    }
  }
  Future<void>addToRecent(RecentSong songModel)async{
    Database db = await getDatabase();
    db.insert('recentListened',songModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<bool> isPresentInFavourites(int id) async {
    Database db = await getDatabase(); // Assuming getDatabase() returns a synchronous Database.

    List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM favouriteSongs WHERE _id = ?',
      [id],
    );

    int count = result.isNotEmpty ? result[0]['count'] : 0;
    print("subhash  $count");
    return count>0;
  }



}

