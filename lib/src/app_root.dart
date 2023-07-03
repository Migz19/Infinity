import 'package:flutter/material.dart';
import 'package:infinity/views/add_member/add_member_screen.dart';

import '../views/splash/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
