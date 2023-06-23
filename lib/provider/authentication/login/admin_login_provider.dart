
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';

class AdminLoginProvider extends ChangeNotifier{

   bool? isLoading;

  Future<void> loginAdmin({required String email,required String password})async {
    isLoading=true;
    notifyListeners();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email, password: password)
        .then((value) {
      print("Login Admin Success : ${value}");
          //
    }).catchError((error) {
       print("Login Admin Error: ${error}");
    });
    isLoading=false;
    notifyListeners();
  }
}