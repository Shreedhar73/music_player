import 'package:dartz/dartz.dart';
import 'package:music_player/app/core/error/failure.dart';
import 'package:music_player/features/splash/domain/entities/permission_entity.dart';

abstract class PermissionRepository {
  Future<Either<Failure,PermissionStatusEntity>> getPermissionStatus();
}