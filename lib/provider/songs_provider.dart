import 'package:flutter/cupertino.dart';
import 'package:music_player_demo/models/recent_listens.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Sqlfite/database_helper.dart';

class SongsProvider extends ChangeNotifier {
  late SongModel _songModel;
  Duration currentPosition=const Duration();
  Duration songDuration=const Duration(seconds: 60);
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();
  List<RecentSong>recentListens=[];

  SongModel get currentSong => _songModel;

  void updateCurrentSong(SongModel songModel) {
    _songModel = songModel;
    notifyListeners();
  }
  void getRecentSongs()async{
    List<RecentSong>list= await _dataBaseHelper.getRecent();
    if(list.length!=recentListens.length){
      print(list==recentListens);
      recentListens=list;
      notifyListeners();
    }
  }
  void addDuration(Duration duration){
    print(duration);
    songDuration=duration;
    notifyListeners();
  }
  void addCurrentPosition(Duration duration){
    currentPosition=duration;
    notifyListeners();
  }
}
