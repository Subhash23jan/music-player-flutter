import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsProvider extends ChangeNotifier {
  late SongModel _songModel;

  // Initialize _songModel in the constructor
  SongsProvider() {
    _songModel = SongModel({}); // You might want to use your actual initialization logic here
  }

  SongModel get currentSong => _songModel;

  void updateCurrentSong(SongModel songModel) {
    _songModel = songModel;
    notifyListeners();
  }
}
