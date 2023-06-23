import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/user/user_model.dart';

class AddMemberProvider extends ChangeNotifier{
 FirebaseHelper  _firebaseHelper=FirebaseHelper();
 bool? isLoadding;
 bool isAdded=false;
 Future<void> addNewMember({required UserModel userModel})
 async {
   isLoadding=true;
   notifyListeners();
   isAdded=await _firebaseHelper.UserRegister(userModel);
   isLoadding=false;
   notifyListeners();
 }
}