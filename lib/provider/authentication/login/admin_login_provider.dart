import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

import '../../../data/local/cache_helper.dart';

class AdminLoginProvider extends ChangeNotifier {
  bool? isLoading;
  FirebaseHelper _fireHelper = FirebaseHelper();
  bool isLogin = false;

  Future<void> loginAdmin(
      {required String email,
      required String password,
      required bool isSelected}) async {
    isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        try {
          await _fireHelper.getUserData(
              UId: value.user!.uid, collectionName: "admin");
          if (FirebaseHelper().admin.isEmpty) {
            isLogin = false;
            return;
          }
          String emailAdmin = FirebaseHelper().admin["email"];
          String passwordAdmin = FirebaseHelper().admin["password"];
          if (email == emailAdmin && password == passwordAdmin) {
            isLogin = true;
            if (isSelected) {
              await CacheHelper.setData(key: "loginType", value: 'admin');
              await CacheHelper.setData(key: "email", value: email);
              await CacheHelper.setData(key: "password", value: password);
            }
            print("Login Admin success");
          } else {
            isLogin = false;
          }
        } catch (error) {
          print("Login FireStore Admin Error: ${error}");
        }
      });
      isLoading = false;
      notifyListeners();
    } catch (error) {
      print("Login Auth Admin Error: ${error}");
      isLoading = false;
      notifyListeners();
    }
  }
}
