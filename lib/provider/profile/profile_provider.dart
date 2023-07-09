



import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

class ProfileProvider extends ChangeNotifier{

  String? getUsername(){
    return FirebaseHelper().userModel?.username;
  }
  String? getUserEmail(){
    return FirebaseHelper().userModel?.email;
  }
}