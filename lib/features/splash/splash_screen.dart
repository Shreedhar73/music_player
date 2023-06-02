import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? hasPermission;
  checkForPermission() async{
    return await OnAudioQuery().checkAndRequest(
      retryRequest: false
    );
  }
  @override
  void initState() {
    super.initState();
  }

  routeToHome(){
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
  }

  checkForExternalPermission() async{
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if( status.isGranted){
      hasPermission = true;
      routeToHome();
    }else if(status.isPermanentlyDenied){
      openAppSettings().then((value) 
      => setState((){})
      );
    }
    
    return status;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E),
      body: FutureBuilder(
        future: checkForPermission(),
        builder: (ctx,snapshot){
          if(snapshot.hasData){
            var permissionStatus = snapshot.data;
            if(permissionStatus == true){
              hasPermission = true;
              routeToHome();
              return const Center(
                child:  Text(
                  'Splash Screen', style: TextStyle(color: Colors.white),
                ),
              );
            }else{
              return Center(
                child: InkWell(
                  onTap: ()async{
                    print("Check for Permission");
                    checkForExternalPermission();
                  },
                  child: const Text("Request permission",style: TextStyle(color: Colors.white),),
                ),
              );
            }
          }else{
            return Center(
              child: InkWell(
                onTap: ()async{
                  checkForExternalPermission();
                },
                child: const Text("Request permission",style: TextStyle(color: Colors.white),),
              ),
            );
          }
        },
      ),
      // body: hasPermission ?? false ?
      // const Center(
      //   child: Text(' Splash Screen',style: TextStyle(color: Colors.white),),
      // )
      // : Center(
      //   child: InkWell(
      //     onTap: ()async{
      //       checkForPermission();
      //     },
      //     child: const Text("Request permission",style: TextStyle(color: Colors.white),),
      //   ),
      // ),
    );
  }
}