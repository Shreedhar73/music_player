import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:music_player/features/splash/presentation/bloc/permission_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? hasPermission;
  @override
  void initState() {
    super.initState();
  }

  routeToHome(){
    Future.delayed(
      const Duration(milliseconds: 100),
      (){
          context.router.replace(
            const BottombarRoute()
          );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A091E),
      body: BlocListener<PermissionBloc,PermissionState>(
        listener: (ctx,state){
          if(state is PermissionGrantedState){
            routeToHome();
          }else if(state is PermissionPermanentlyDeniedState){
            
          }else{
          }
        },
        child: BlocBuilder<PermissionBloc,PermissionState>(
          bloc: context.read<PermissionBloc>()..add(GetPermission()),
          builder: (context, state) {
            return  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(state is PermissionPermanentlyDeniedState || state is PermissionStateInitial)
                InkWell(
                  onTap: (){
                    openAppSettings().then(
                      (value) => value ? context.read<PermissionBloc>().add(GetPermission()) : null 
                    );
                  },
                  child: const Text("Allow permission", style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
                if(state is PermissionRestrictedState)
                InkWell(
                  onTap: (){ 
                    context.read<PermissionBloc>().add(GetPermission());
                  },
                  child: const Text("Allow permission", style: TextStyle(color: Colors.white, fontSize: 18),),
                ),
                const Center(
                  child: Text("Splash Screen", style: TextStyle(color: Colors.white),),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}