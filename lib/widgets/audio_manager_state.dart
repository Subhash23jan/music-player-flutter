part of 'audio_manager_bloc.dart';

@immutable
abstract class AudioManagerState {}

class AudioManagerInitial extends AudioManagerState {}
class AudioManagerPlaying extends AudioManagerState{
  final SongModel songModel;
  AudioManagerPlaying(this.songModel);
}
class AudioManagerPause extends AudioManagerState{
  final SongModel songModel;
  AudioManagerPause(this.songModel);

}

