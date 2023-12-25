import 'package:on_audio_query/on_audio_query.dart';

class PlayListSong extends SongModel{
  PlayListSong(super.info, this.playListId);
  final int playListId;
}