import 'package:cloud_firestore/cloud_firestore.dart';
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
        print("Login Member Success : ${value.user!.uid}");
        //
        try{
          // _fireHelper
          //  .getUserData(UId: value.user!.uid, collectionName: "admin") ;
          await _fireHelper
              .getUserData(UId: value.user!.uid, collectionName: "users");
          print("val : ${_fireHelper.admin}");
          if(_fireHelper.admin.isEmpty){
            isLogin=false;
            return;
          }
             userModel=_fireHelper.userModel;
            isLogin = true;
          if(isSelected){
            await CacheHelper.setData(key: "loginType", value: 'member');
            await CacheHelper.setData(key: "email", value: userModel!.email);
            await CacheHelper.setData(
                key: "password", value: userModel!.password);
          }
          print("Login Member success");
          }



        catch(error){
          print("Login FireStore Admin Error: ${error}");
        }

      });
      isLoading = false;
      notifyListeners();
    }catch(error)
    {
      print("Login Auth Admin Error: ${error}");
      isLoading = false;
      notifyListeners();
    }
  }
}