import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/user/user_model.dart';

class AddMemberProvider extends ChangeNotifier{
 FirebaseHelper  _firebaseHelper=FirebaseHelper();
 bool? isLoading;
 bool isAdded=false;
 String? committee;
 Future<void> addNewMember({required UserModel userModel})
 async {
   isLoading=true;
   notifyListeners();
   isAdded=await _firebaseHelper.UserRegister(userModel);
   isLoading=false;
   notifyListeners();
 }
 List<String>committeesList=['Hr','Media','Pr','Events','HighBoard','Marketing'];
 List<String>rolesList=['Head','Vice Head','Highboard','Member'];

}