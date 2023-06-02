import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:on_audio_query/on_audio_query.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? hasPermission;
  checkForPermission() async{
    hasPermission = await OnAudioQuery().checkAndRequest(
      retryRequest: false
    );
    hasPermission ?? false ? setState((){}) : null;
  }
  @override
  void initState() {
    checkForPermission();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback( (timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 100),
        (){
          if(hasPermission ?? false){
            context.router.replace(
              const BottombarRoute()
            );
          }
        }
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E),
      body: hasPermission ?? false ?
      const Center(
        child: Text(' Splash Screen',style: TextStyle(color: Colors.white),),
      )
      : Center(
        child: InkWell(
          onTap: ()async{
            checkForPermission();
          },
          child: const Text("Request permission",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}