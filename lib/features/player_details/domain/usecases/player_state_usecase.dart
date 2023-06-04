import 'package:dartz/dartz.dart';
import 'package:music_player/features/player_details/data/models/progressbar_state_model.dart';
import 'package:music_player/features/player_details/domain/repositories/player_state_repository.dart';

import '../../../../app/core/error/failure.dart';
import '../../../../app/core/usecases/usecases.dart';

class PlayerStateUseCase implements UseCase<Stream<ProgressBarState>,NoParams>{
  final PlayerStateRepository playerStateRepository;
  PlayerStateUseCase({required this.playerStateRepository});

  @override
  Future<Either<Failure,Stream<ProgressBarState>>> call(params){
    return playerStateRepository.getPlayerState();
  }
}

class PlayerSeekUsecase implements UseCase<dynamic, SeekParams>{
  final PlayerStateRepository playerStateRepository;
  PlayerSeekUsecase({required this.playerStateRepository});

  @override
  Future<Either<Failure,dynamic>> call(params){
    return playerStateRepository.seek(
      params.duration
    );
  }
}

class SeekParams{
  final Duration? duration;
  SeekParams({this.duration});
}
