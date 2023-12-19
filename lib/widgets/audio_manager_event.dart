part of 'audio_manager_bloc.dart';

@immutable
abstract class AudioManagerEvent {}

class AudioPlay extends AudioManagerEvent{
  final SongModel songModel;
  AudioPlay(this.songModel);
}
class AudioPause extends AudioManagerEvent{
  final SongModel songModel;
  AudioPause(this.songModel);
}
class AudioResume extends AudioManagerEvent{
  final SongModel songModel;
  AudioResume(this.songModel);
}
