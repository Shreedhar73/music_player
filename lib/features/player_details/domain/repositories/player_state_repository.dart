import 'package:dartz/dartz.dart';
import 'package:music_player/features/player_details/data/models/progressbar_state_model.dart';

import '../../../../app/core/error/failure.dart';

abstract class PlayerStateRepository{
  Future<Either<Failure,Stream<ProgressBarState>>> getPlayerState();
  Future<Either<Failure,dynamic>> seek(
    Duration? duration
  );
}