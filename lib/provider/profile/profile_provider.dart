import 'dart:async';
import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinity/controller/custom_file_picker.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/controller/custom_image_picker.dart';

class ProfileProvider extends ChangeNotifier{
bool isLoading=false;
bool imageNotNull=false;
File? profImg;
FirebaseHelper firebaseHelper=FirebaseHelper();
CustomImagePicker imagePicker=CustomImagePicker();
  String getUsername(){
    return "Ahmed";
  }
  Future<String> getUserEmail()async{
    await firebaseHelper.getUserData(UId:FirebaseAuth.instance.currentUser!.uid , collectionName: "admin");
    print("emaiaaaaail;"+firebaseHelper.userModel!.email);
    return firebaseHelper.userModel!.email;

  }
  Future<void> logout() async {
    isLoading=true;
    notifyListeners();
    await firebaseHelper.userLogOut();
    isLoading=false;
    notifyListeners();
  }
  Future<void> uploadImage (String imageProvider)async{
    isLoading =true;
    notifyListeners();
    profImg=await imagePicker.pickImage(imageProvider);
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
// Future<void> uploadFiles ()async{
//   isLoading =true;
//   notifyListeners();
//   List<PlatformFile>?files=await CustomFilePicker().pickMultipleFiles();
//   if(files?.first!=null) {
//     FirebaseHelper().uploadFiles(files!);
//   }
//   isLoading=false;
//   notifyListeners();
//
// }
}