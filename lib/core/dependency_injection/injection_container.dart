import 'package:get_it/get_it.dart';
import 'package:music_player/features/discover/data/datasource/discover_music_datasource.dart';
import 'package:music_player/features/discover/domain/repositories/discover_music_repository.dart';
import 'package:music_player/features/discover/domain/usecases/discover_music_usecase.dart';
import 'package:music_player/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:music_player/features/splash/data/datasource/app_permission_datasource.dart';
import 'package:music_player/features/splash/data/repositories/permission_repository_impl.dart';
import 'package:music_player/features/splash/domain/repositories/permission_repository.dart';
import 'package:music_player/features/splash/domain/usecases/permission_status_usecase.dart';
import 'package:music_player/features/splash/presentation/bloc/permission_bloc.dart';

import '../../features/discover/data/repositories/discover_music_repository_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //register repositories
  sl.registerLazySingleton<DiscoverMusicRepository>(
    () => DiscoverMusicRepositoryImpl(
      discoverMusicDataSource: sl()
    )
  );
  sl.registerLazySingleton<PermissionRepository>(
    () => PermissionRepositoryImpl(
      permissionDataSource: sl()
    )
  );
  //register usecases
  sl.registerLazySingleton<DiscoverMusicUsecase>(
    () => DiscoverMusicUsecase(
      discoverMusicRepository: sl()
    )
  );

  sl.registerLazySingleton<PermissionStatusUseCase>(
    () => PermissionStatusUseCase(
      permissionRepository: sl()
    )
  );
  //register data source
  sl.registerLazySingleton<DiscoverMusicDataSource>(
    () => DiscoverMusicDataSourceImpl()
  );

  sl.registerLazySingleton<AppPermissionDataSource>(
    () => AppPermissionDataSourceImpl()
  );
  
  // register bloc
  sl.registerFactory<DiscoverBloc>(() => DiscoverBloc(
    discoverMusicUsecase: sl()
  ));

  sl.registerFactory<PermissionBloc>(() => PermissionBloc(
    permissionUseCase: sl()
  ));

 
  
  
}