import 'package:dartz/dartz.dart';
import 'package:music_player/app/core/error/failure.dart';
import 'package:music_player/features/splash/data/datasource/app_permission_datasource.dart';
import 'package:music_player/features/splash/domain/entities/permission_entity.dart';
import 'package:music_player/features/splash/domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl extends PermissionRepository{
  final AppPermissionDataSource permissionDataSource;

  PermissionRepositoryImpl({required this.permissionDataSource});

  @override
  Future<Either<Failure, PermissionStatusEntity>> getPermissionStatus() async{
    try{
      final response = await permissionDataSource.askForPermission();
      return Right(response);
    }catch(e){
      return left(ServerFailure());
    }
  }
}