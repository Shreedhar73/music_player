import 'package:dartz/dartz.dart';
import 'package:music_player/features/discover/data/datasource/discover_music_datasource.dart';
import 'package:music_player/features/discover/domain/repositories/discover_music_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../app/core/error/failure.dart';

class DiscoverMusicRepositoryImpl implements DiscoverMusicRepository{
  final DiscoverMusicDataSource discoverMusicDataSource;
  DiscoverMusicRepositoryImpl({required this.discoverMusicDataSource});

  @override
  Future<Either<Failure,List<SongModel?>>> getAllSongs()async{
    try{
      final response = await discoverMusicDataSource.getAllSongs();
      return right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }
}