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
            emit(AudioManagerPlaying(songModel));
      },);
      on<AudioPause>((event, emit){
        emit(AudioManagerPause(event.songModel));
      });
      on<AudioResume>((event, emit){
        emit(AudioManagerPlaying(event.songModel));
      });
    });
  }
}
