

import 'package:dartz/dartz.dart';
import 'package:music_player/app/core/usecases/usecases.dart';
import 'package:music_player/features/player_details/domain/repositories/audio_player_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../app/core/error/failure.dart';

class PlayMusicUseCase implements UseCase<dynamic,NoParams>{
  final AudioPlayerRepository audioPlayerRepository;
  PlayMusicUseCase({required this.audioPlayerRepository});

  @override
  Future<Either<Failure,dynamic>> call(params){
    return audioPlayerRepository.playMusic();
  }
}

class PauseMusicUseCase implements UseCase<dynamic,NoParams>{
  final AudioPlayerRepository audioPlayerRepository;
  PauseMusicUseCase({required this.audioPlayerRepository});

  @override
  Future<Either<Failure,dynamic>> call(params){
    return audioPlayerRepository.pauseMusic();
  }
}

class InitializeAudioPlayerUseCase implements UseCase<dynamic,InitializeAudioPlayerParams>{
  final AudioPlayerRepository audioPlayerRepository;
  InitializeAudioPlayerUseCase({required this.audioPlayerRepository});

  @override
  Future<Either<Failure,dynamic>> call(params){
    return audioPlayerRepository.initializeAudioPlayer(
      params.song,
      params.artWork
    );
  }
}

class InitializeAudioPlayerParams{
  final SongModel? song;
  final String? artWork;
  InitializeAudioPlayerParams({
    this.song,
    this.artWork
  });
} 