import 'package:flutter/material.dart';
import 'package:infinity/views/committees/committees_screen.dart';
import 'package:infinity/views/events/events_screen.dart';
import 'package:infinity/views/home/home_screen.dart';
import 'package:infinity/views/profile/profile_screen.dart';

class NavigatorProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<String> screenTitles = ['Home', "Committees", "Events", "Profile"];
  List<Widget> screens = [
    HomeScreen(),
    CommitteeScreen(),
    EventScreen(),
    ProfileScreen(),
  ];

  void changeScreen({required index}) {
    currentIndex = index;
    notifyListeners();
  }
}
