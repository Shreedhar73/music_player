import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:music_player/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:music_player/features/player_details/presentation/bloc/audio_player_bloc.dart';
import 'package:music_player/features/splash/presentation/bloc/permission_bloc.dart';

import '../../core/dependency_injection/injection_container.dart';
import '../../features/player_details/presentation/bloc/player_state/player_state_bloc.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> sl<DiscoverBloc>()),
        BlocProvider(create: (context)=> sl<PermissionBloc>()),
        BlocProvider(create: (context)=> sl<AudioPlayerBloc>()),
        BlocProvider(create: (context)=> sl<PlayerStateBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}