import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/features/player_details/data/datasource/audio_player_datasource.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'audio_player_state.dart';
part 'audio_player_events.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent ,AudioPlayerState>{
  final AudioPlayerDataSource audioPlayerUsecase;
  AudioPlayerBloc({required this.audioPlayerUsecase}) : super(AudioPlayerInitial()){
    on<AudioPlayEvent>(_playMusic);
    on<AudioPauseEvent>(_pauseMusic);
    on<AudioPlayerInitializeEvent>(_initializeAudioPlayer);
    on<AudioPlayerDisposeEvent>(_disposeAudioPlayer);
  }

  FutureOr<void> _playMusic(AudioPlayEvent event, Emitter<AudioPlayerState> emit) async{
    emit(AudioPlayerInitial());
    audioPlayerUsecase.play();
    emit(IsPlayingState());
  }

  FutureOr<void> _pauseMusic(AudioPauseEvent event, Emitter<AudioPlayerState> emit) async{
    emit(AudioPlayerInitial());
    audioPlayerUsecase.pause();
    emit(IsPausedState());
  } 

  FutureOr<void> _initializeAudioPlayer(AudioPlayerInitializeEvent event, Emitter<AudioPlayerState> emit) async{
    emit(AudioPlayerInitial());
    audioPlayerUsecase.initializeAudioPlayer(
      song: event.songModel,
      artWork: ''
    );
    emit(AudioPlayerInitialized());
  }

  FutureOr<void> _disposeAudioPlayer(AudioPlayerDisposeEvent event, Emitter<AudioPlayerState> emit) async{
    emit(AudioPlayerInitial());
  }
}