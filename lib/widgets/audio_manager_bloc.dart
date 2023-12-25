import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'audio_manager_event.dart';
part 'audio_manager_state.dart';

class AudioManagerBloc extends Bloc<AudioManagerEvent, AudioManagerState> {
  AudioManagerBloc() : super(AudioManagerInitial()) {
    on<AudioManagerEvent>((event, emit) {
      on<AudioPlay>((event, emit) {
            SongModel songModel=event.songModel;
            return emit(AudioManagerPlaying(songModel));
      },);
      on<AudioPause>((event, emit){
        return emit(AudioManagerPause(event.songModel));
      });
      on<AudioResume>((event, emit) {
        SongModel songModel=event.songModel;
        return emit(AudioManagerPlaying(songModel));
      },);
    });
  }
}
