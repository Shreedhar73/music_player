
import 'package:music_player/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_player/features/player_details/data/datasource/audio_player_datasource.dart';
import 'package:music_player/features/player_details/domain/repositories/player_state_repository.dart';

import '../models/progressbar_state_model.dart';

class PlayerStateRepositoryImpl extends PlayerStateRepository{
  final AudioPlayerDataSource audioPlayerDataSource;
  PlayerStateRepositoryImpl({required this.audioPlayerDataSource});
  @override
  Future<Either<Failure, Stream<ProgressBarState>>> getPlayerState() async{
    try{
      final response = await audioPlayerDataSource.getPlayerState();
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, dynamic>> seek(Duration? duration) async{
    try{
      final response = await audioPlayerDataSource.onSeek(duration!);
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }

}