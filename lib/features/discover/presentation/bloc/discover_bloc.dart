import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:music_player/app/core/usecases/usecases.dart';
import 'package:music_player/features/discover/domain/usecases/discover_music_usecase.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState>{
  final DiscoverMusicUsecase discoverMusicUsecase;
  DiscoverBloc({
    required this.discoverMusicUsecase
  }) : super (DiscoverInitial()){
    on<GetAllSongsEvent>(_getAllSongs);
  }

  FutureOr<void> _getAllSongs(GetAllSongsEvent event, Emitter<DiscoverState> emit ) async{
    emit(DiscoverLoading());
    final results = await discoverMusicUsecase.call(NoParams());
    results.fold(
      (l) => emit(DiscoverError()), 
      (r) => emit(AllSongsLoadedState(
        songsList: r
      ))
    );
  }
}