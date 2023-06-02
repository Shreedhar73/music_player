import 'package:get_it/get_it.dart';
import 'package:music_player/features/discover/data/datasource/discover_music_datasource.dart';
import 'package:music_player/features/discover/domain/repositories/discover_music_repository.dart';
import 'package:music_player/features/discover/domain/usecases/discover_music_usecase.dart';
import 'package:music_player/features/discover/presentation/bloc/discover_bloc.dart';

import '../../features/discover/data/repositories/discover_music_repository_impl.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //register repositories
  sl.registerLazySingleton<DiscoverMusicRepository>(
    () => DiscoverMusicRepositoryImpl(
      discoverMusicDataSource: sl()
    )
  );
  
  //register usecases
  sl.registerLazySingleton<DiscoverMusicUsecase>(
    () => DiscoverMusicUsecase(
      discoverMusicRepository: sl()
    )
  );
  //register data source
  sl.registerLazySingleton<DiscoverMusicDataSource>(
    () => DiscoverMusicDataSourceImpl()
  );
  
  // register bloc
  sl.registerFactory<DiscoverBloc>(() => DiscoverBloc(
    discoverMusicUsecase: sl()
  ));

 
  
  
}