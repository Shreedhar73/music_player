import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/features/player_details/data/datasource/audio_player_datasource.dart';
import '../../../data/models/progressbar_state_model.dart';

part 'player_state_states.dart';
part 'player_state_events.dart';

class PlayerStateBloc extends Bloc<PlayerStateEvent, PlayerStateState>{
  final AudioPlayerDataSource audioPlayerUseCase;
  PlayerStateBloc({required this.audioPlayerUseCase}) :super (PlayerStateInitial()){
    on<GetPlayerStateEvent>(_getAudioPlayerState, transformer: restartable());
  }

  FutureOr<void> _getAudioPlayerState(GetPlayerStateEvent event, Emitter<PlayerStateState> emit) async{
    emit(PlayerStateInitial());
    var result = await audioPlayerUseCase.getPlayerState();
    await emit.forEach(
      result, 
      onData: (ProgressBarState progressBarState) { 
        emit(PlayerStateInitial());
        return AudioProgressBarState(
          current: progressBarState.current,
          buffered: progressBarState.buffered,
          total: progressBarState.total
        );
      }
    );
  }

  Future<void> onSeek(Duration duration) async{
    audioPlayerUseCase.onSeek(duration);
  }
  
}