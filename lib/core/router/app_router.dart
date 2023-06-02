import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:music_player/features/splash/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../features/bottom_nav/presentation/screens/bottom_bar.dart';
import '../../features/discover/presentation/screens/discover.dart';
import '../../features/favorites/presentation/screens/favorites.dart';
import '../../features/player_details/presentation/screens/music_player_screen.dart';
import '../../features/playlists/presentation/screens/playlists.dart';

part 'app_router.gr.dart';            
              
@AutoRouterConfig()      
class AppRouter extends _$AppRouter {      
    
  @override      
  List<AutoRoute> get routes => [     
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
      maintainState: false,
      path: '/splash'
    ),
    AutoRoute(
      page: BottombarRoute.page,
      path: '/bottombar',
      children: [
        AutoRoute(
          page: DiscoverRoute.page,
          path: 'discover',
          maintainState: true
        ),
        AutoRoute(
          page: FavoritesRoute.page,
          path: 'favorite',
          maintainState: true
        ),
        AutoRoute(
          page: PlaylistsRoute.page,
          path: 'playLists',
          maintainState: true
        ),
      ],
      maintainState: true
    ), 
    AutoRoute(
      page: MusicPlayerRoute.page,
      path: '/player',
      maintainState: true
    ),
  ];    
 } 