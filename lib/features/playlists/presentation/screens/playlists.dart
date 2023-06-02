import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()  
class PlaylistsScreen extends StatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Playlists'),
    );
  }
}