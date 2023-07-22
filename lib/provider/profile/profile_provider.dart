import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

class ProfileProvider extends ChangeNotifier{
bool isLoading=false;

  String getUsername(){

    return "AHmed";
  }
  String getUserEmail(){
    return "ahmed@gmail.com";
  }
  Future<void> logout() async {
    isLoading=true;
    notifyListeners();
    await FirebaseHelper().userLogOut();
    isLoading=false;
    notifyListeners();
  }
}