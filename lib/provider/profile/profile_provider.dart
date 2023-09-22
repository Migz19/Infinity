import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinity/controller/custom_image_picker.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/user/user_model.dart';

class ProfileProvider extends ChangeNotifier{
bool isLoading=false;
bool imageNotNull=false;
File? profImg;

  Future<UserModel> getUserData()async{
    UserModel model=  UserModel.fromJson(json:await  FirebaseHelper().getUserData(UId:FirebaseAuth.instance.currentUser!.uid , collectionName: "admin"));
    notifyListeners();
    return model;
  }
  Future<void> logout() async {
    isLoading=true;
    notifyListeners();
    await FirebaseHelper().userLogOut();
    isLoading=false;
    notifyListeners();
  }
  Future<void> uploadImage (String imageProvider)async{
    isLoading =true;
    notifyListeners();
    profImg=await CustomImagePicker().pickImage(imageProvider);
    if(profImg!=null) {
      imageNotNull=true;
      FirebaseHelper().uploadProfileImage(profImg!);
    }
   isLoading=false;
    notifyListeners();

}
  Future <void> fetchImage (String imageProvider) async{
    if(imageNotNull) {
      isLoading=true;
      notifyListeners();
      await FirebaseHelper().fetchProfileImage();
    }

  }

}