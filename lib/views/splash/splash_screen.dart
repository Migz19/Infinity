import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/views/auth/login/login_screen.dart';

import '../../core/utils/app_assets.dart';
class SplashScreen extends StatefulWidget  {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 4000),
    vsync: this,
  )..forward().then((value) => startAnimation());
  late final AnimationController _logoController = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  );
  late final Animation<Offset> _offsetLeafAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: Offset((context.width*0.05), 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));
  late final Animation<Offset> _offsetRightAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: Offset(-(context.width*0.05), 0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  ));
  late final Animation<Offset> _offsetLogoAnimation = Tween<Offset>(
    end: Offset.zero,
    begin: Offset(0, -(context.height*0.02)),
  ).animate(CurvedAnimation(
    parent: _logoController,
    curve: Curves.bounceOut,
  ));
  void startAnimation() async {
    // Start Animation of logo
    await _logoController.forward();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  LoginScreen(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.backgroundLogo,fit: BoxFit.fill,),
          Container(width: double.infinity,height: double.infinity,
          color: Colors.white,),
          Center(
            child: SlideTransition(
              position: _offsetLogoAnimation,
              child: Hero(tag: 'logo',
                  child: Image.asset(AppAssets.logo,height: 300,width: 300)),
            ),
          ),
          Positioned(bottom: 64 ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _offsetLeafAnimation,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 15,width: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0,),
                          color: AppColor.primary
                      ),),
                  ),
                  Text("Infinity",
                    style: TextStyle(fontSize: 28,fontWeight:FontWeight.normal,color: AppColor.primary),
                  ),
                  SlideTransition(
                    position:_offsetRightAnimation,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: 15,width: 15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0,),
                          color: AppColor.primary
                      ),),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
