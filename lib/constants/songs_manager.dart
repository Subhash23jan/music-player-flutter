import 'package:audioplayers/audioplayers.dart';
import 'package:music_player_demo/models/recent_listens.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongsManager{

  static List<SongModel>songsList=[];
  static List<SongModel>favouriteSongs=[];
  static List<RecentSong>recentListens=[];
  static bool  isInFavourites=false;
  static AudioPlayer? audioPlayer;
  static  List<String> kannadaImages=[
    "https://i.ytimg.com/vi/qXgF-iJ_ezE/maxresdefault.jpg",
    "https://upload.wikimedia.org/wikipedia/en/c/cc/K.G.F_Chapter_1_poster.jpg",
    "https://upload.wikimedia.org/wikipedia/en/7/77/Ugramm.jpg",
    "https://i.ytimg.com/vi/HLVLHf-lP08/maxresdefault.jpg",
    "https://m.media-amazon.com/images/M/MV5BYTM3ZTQ1ZGEtNmVjZC00MTcyLTkyZTEtZWExYTUwMDRjMGE1XkEyXkFqcGdeQXVyNTE0NDY5Njc@._V1_.jpg"
  ];
}