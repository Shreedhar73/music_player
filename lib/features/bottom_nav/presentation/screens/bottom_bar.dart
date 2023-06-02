import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player/core/router/app_router.dart';
import 'package:on_audio_query/on_audio_query.dart';

@RoutePage()  
class BottombarPage extends StatefulWidget {
  const BottombarPage({super.key});

  @override
  State<BottombarPage> createState() => _BottombarPageState();
}

class _BottombarPageState extends State<BottombarPage> with TickerProviderStateMixin {
  int currentValue = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  late AnimationController _controller3;
  late Animation<double> _animation3;

  late AnimationController _controller4;
  late Animation<double> _animation4;

  List<AnimationController> animationControllerList = [];
  List<Animation> animationsList = [];
  checkForPermission() async{
    await OnAudioQuery().checkAndRequest(
      retryRequest: false
    );
  }

  @override
  void initState() {
    checkForPermission();
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 25, end: 33).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller2 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation2 = Tween<double>(begin: 25, end: 33).animate(CurvedAnimation(
        parent: _controller2,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller3 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation3 = Tween<double>(begin: 25, end: 33).animate(CurvedAnimation(
        parent: _controller3,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

    _controller4 =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation4 = Tween<double>(begin: 25, end: 33).animate(CurvedAnimation(
        parent: _controller4,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });

      animationControllerList = [ _controller,_controller2,_controller3,_controller4];
      animationsList = [_animation,_animation2,_animation3,_animation4];
      animateFunctions = [
        (){
          _controller.forward();
          _controller2.reverse();
          _controller3.reverse();
          _controller4.reverse();
        },
        (){
          _controller.reverse();
          _controller2.forward();
          _controller3.reverse();
          _controller4.reverse();
        },
        (){
          _controller.reverse();
          _controller2.reverse();
          _controller3.forward();
          _controller4.reverse();
        },
      ];
    _controller.forward();

  }
  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }


  var routes = const [
    DiscoverRoute(),
    PlaylistsRoute(),
    FavoritesRoute()
  ];
  
  var bottomNavBarItesm = [
    {
      'name' : 'Discover',
      'icon' : Icons.home_outlined,
    },
    {
      'name' : 'PlayList',
      'icon' : Icons.library_music_outlined
    },
    {
      'name' : 'Favorites',
      'icon' : Icons.favorite
    }
  ];
  var animateFunctions = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: AutoTabsRouter(
          routes: routes,
          builder: (context, child) {
            final tabsTouter = AutoTabsRouter.of(context);
            return SafeArea(
              child: Scaffold(
                backgroundColor: const Color(0xFF0A092b),
                body: Stack(
                  children: [
                    child,
                     Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: size.width * .14,
                        width: size.width,
                        padding: const EdgeInsets.only(top: 15),
                        margin: EdgeInsets.only(left: size.width * .04, right: size.width * .04,),
                        decoration:  BoxDecoration(
                          color: const Color(0xFF0A091E),
                          borderRadius: const BorderRadius.only(
                            topLeft : Radius.circular(30),
                            topRight : Radius.circular(30),
                          ),
                          boxShadow:  [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              offset: const Offset(0, 0),
                              blurRadius: 30,
                              spreadRadius: 0.5,
                            ),
                          ]
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          padding: EdgeInsets.zero,
                          itemExtent: size.width/3-10,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx,index){
                            return IconButton(
                              icon: Icon(
                                bottomNavBarItesm[index]['icon'] as IconData,
                                color: tabsTouter.activeIndex == index ? Colors.blue : Colors.white,
                                size: animationsList[index].value,
                              ),
                              onPressed: () {
                                tabsTouter.setActiveIndex(index);
                                setState(() {
                                  Function.apply(animateFunctions[index],null);
                                  HapticFeedback.lightImpact();
                                });
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            );
                          },
                        ),
                      ),
                     )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
