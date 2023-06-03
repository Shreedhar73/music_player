// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    EmptyRouterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmptyRouterPage(),
      );
    },
    BottombarRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BottombarPage(),
      );
    },
    DiscoverRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DiscoverScreen(),
      );
    },
    FavoritesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FavoritesScreen(),
      );
    },
    MusicPlayerRoute.name: (routeData) {
      final args = routeData.argsAs<MusicPlayerRouteArgs>(
          orElse: () => const MusicPlayerRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MusicPlayerScreen(
          key: args.key,
          songList: args.songList,
          index: args.index,
        ),
      );
    },
    PlaylistsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PlaylistsScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [EmptyRouterPage]
class EmptyRouterRoute extends PageRouteInfo<void> {
  const EmptyRouterRoute({List<PageRouteInfo>? children})
      : super(
          EmptyRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmptyRouterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [BottombarPage]
class BottombarRoute extends PageRouteInfo<void> {
  const BottombarRoute({List<PageRouteInfo>? children})
      : super(
          BottombarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottombarRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DiscoverScreen]
class DiscoverRoute extends PageRouteInfo<void> {
  const DiscoverRoute({List<PageRouteInfo>? children})
      : super(
          DiscoverRoute.name,
          initialChildren: children,
        );

  static const String name = 'DiscoverRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
      : super(
          FavoritesRoute.name,
          initialChildren: children,
        );

  static const String name = 'FavoritesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MusicPlayerScreen]
class MusicPlayerRoute extends PageRouteInfo<MusicPlayerRouteArgs> {
  MusicPlayerRoute({
    Key? key,
    List<SongModel?>? songList,
    int index = 0,
    List<PageRouteInfo>? children,
  }) : super(
          MusicPlayerRoute.name,
          args: MusicPlayerRouteArgs(
            key: key,
            songList: songList,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'MusicPlayerRoute';

  static const PageInfo<MusicPlayerRouteArgs> page =
      PageInfo<MusicPlayerRouteArgs>(name);
}

class MusicPlayerRouteArgs {
  const MusicPlayerRouteArgs({
    this.key,
    this.songList,
    this.index = 0,
  });

  final Key? key;

  final List<SongModel?>? songList;

  final int index;

  @override
  String toString() {
    return 'MusicPlayerRouteArgs{key: $key, songList: $songList, index: $index}';
  }
}

/// generated route for
/// [PlaylistsScreen]
class PlaylistsRoute extends PageRouteInfo<void> {
  const PlaylistsRoute({List<PageRouteInfo>? children})
      : super(
          PlaylistsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PlaylistsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
