import 'package:dartz/dartz.dart';
import 'package:music_player/app/core/error/failure.dart';
import 'package:music_player/app/core/usecases/usecases.dart';
import 'package:music_player/features/discover/domain/repositories/discover_music_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

class DiscoverMusicUsecase implements UseCase<List<SongModel?>, NoParams>{
  final DiscoverMusicRepository discoverMusicRepository;
  DiscoverMusicUsecase({required this.discoverMusicRepository});

  @override
  Future<Either<Failure,List<SongModel?>>> call(params){
    return discoverMusicRepository.getAllSongs();
  }
}