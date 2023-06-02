import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()  
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Discover'),
    );
  }
}