
import 'package:dartz/dartz.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../../app/core/error/failure.dart';

abstract class DiscoverMusicRepository {
  Future<Either<Failure,List<SongModel?>>> getAllSongs();
}