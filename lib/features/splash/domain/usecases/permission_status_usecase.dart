import 'package:dartz/dartz.dart';
import 'package:music_player/app/core/usecases/usecases.dart';
import 'package:music_player/features/splash/domain/entities/permission_entity.dart';
import 'package:music_player/features/splash/domain/repositories/permission_repository.dart';

import '../../../../app/core/error/failure.dart';

class PermissionStatusUseCase implements UseCase<PermissionStatusEntity,NoParams>{
  final PermissionRepository permissionRepository;
  PermissionStatusUseCase({required this.permissionRepository});

  @override
  Future<Either<Failure, PermissionStatusEntity>> call(params){
    return permissionRepository.getPermissionStatus();
  }
}