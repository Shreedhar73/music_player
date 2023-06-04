import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/features/player_details/domain/usecases/player_state_usecase.dart';
import '../../../../../app/core/usecases/usecases.dart';
import '../../../data/models/progressbar_state_model.dart';

part 'player_state_states.dart';
part 'player_state_events.dart';

class PlayerStateBloc extends Bloc<PlayerStateEvent, PlayerStateState>{
  final PlayerStateUseCase playerStateUseCase;
  final PlayerSeekUsecase playerSeekUsecase;
  PlayerStateBloc({required this.playerStateUseCase, required this.playerSeekUsecase}) :super (PlayerStateInitial()){
    on<GetPlayerStateEvent>(_getAudioPlayerState, transformer: restartable());
  }

  FutureOr<void> _getAudioPlayerState(GetPlayerStateEvent event, Emitter<PlayerStateState> emit) async{
    emit(PlayerStateInitial());
    var results = await playerStateUseCase.call(NoParams());
    Stream<ProgressBarState>? playerStream;
    results.fold((l) => emit(PlayerStateError()), 
    (result) async {
      playerStream = result;
    });

    if(playerStream != null){
      return emit.forEach(
        playerStream!, 
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
  }

  Future<void> onSeek(Duration duration) async{
    playerSeekUsecase.call(SeekParams(duration: duration));
  }
  
}