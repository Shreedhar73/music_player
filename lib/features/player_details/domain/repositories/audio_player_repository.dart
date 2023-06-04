import 'package:dartz/dartz.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../app/core/error/failure.dart';

abstract class AudioPlayerRepository{
  Future<Either<Failure,dynamic>> playMusic();
  Future<Either<Failure,dynamic>> pauseMusic();
  Future<Either<Failure,dynamic>> initializeAudioPlayer(SongModel? song, String? artWork);
  Future<Either<Failure,double>> disposeMusicPlayer();
}