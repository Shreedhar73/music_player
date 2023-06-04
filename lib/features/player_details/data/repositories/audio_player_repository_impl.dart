
import 'package:music_player/app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:music_player/features/player_details/data/datasource/audio_player_datasource.dart';
import 'package:music_player/features/player_details/domain/repositories/audio_player_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerRepositoryImpl extends AudioPlayerRepository{
  final AudioPlayerDataSource audioPlayerDataSource;
  AudioPlayerRepositoryImpl({required this.audioPlayerDataSource});

  @override
  Future<Either<Failure, double>> disposeMusicPlayer() {
    throw UnimplementedError();
   
  }

  @override
  Future<Either<Failure, dynamic>> initializeAudioPlayer(SongModel? song,String? artWork) async{
    try{
      final response = await audioPlayerDataSource.initializeAudioPlayer(
        song: song,
        artWork: artWork
      );
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> pauseMusic() async{
    try{
      final response = await audioPlayerDataSource.pause();
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, dynamic>> playMusic() async{
    try{
      final response = await audioPlayerDataSource.play( );
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }

}