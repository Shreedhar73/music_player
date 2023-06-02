import 'package:flutter/material.dart';
import 'package:music_player/core/dependency_injection/injection_container.dart' as di;
import 'app/view/app.dart';

void main() async{
  di.init();
  runApp(MyApp());
}


