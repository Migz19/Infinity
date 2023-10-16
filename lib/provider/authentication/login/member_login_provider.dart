import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

import '../../../models/user/user_model.dart';

class MemberLoginProvider extends ChangeNotifier {
  bool? isLoading;
  FirebaseHelper _fireHelper = FirebaseHelper();
  bool isLogin=false;
  UserModel ?userModel;
  Future<void> loginMember(
      {required String email, required String password,required bool isSelected}) async {
    isLoading = true;
    notifyListeners();
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        try{
          await _fireHelper.getUserData(UId: value.user!.uid, collectionName: "users");
             userModel=FirebaseHelper().userModel;
            isLogin = true;
          if(isSelected){
            await CacheHelper.clear();
            await CacheHelper.setData(key: "loginType", value: 2);
            await CacheHelper.setData(key: "email", value: userModel!.email);
            await CacheHelper.setData(key: "password", value: userModel!.password);
            print('00000000000000000  '+CacheHelper.getData(key: 'email').toString());
          }
          }
        catch(error){
          isLogin=false;
          print("Login FireStore Member Error: ${error}");
          isLoading = false;
          notifyListeners();
          return;
        }

      });
      isLoading = false;
      notifyListeners();
    }catch(error)
    {
      isLogin=false;
      print("Login Auth Member Error: ${error}");
      isLoading = false;
      notifyListeners();
    }
  }
}