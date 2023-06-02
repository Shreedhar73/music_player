import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()  
class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Text('Player Screen'),
    );
  }
}