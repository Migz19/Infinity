import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/user/user_model.dart';

class AddMemberProvider extends ChangeNotifier{
 FirebaseHelper  _firebaseHelper=FirebaseHelper();
 bool? isLoading;
 bool isAdded=false;
 String addMemberMsg="";
 String? committee;
 String?role;
 bool isAdmin=false;
 Future<void> addNewMember({required UserModel userModel})
 async {
   isLoading=true;
   notifyListeners();
   if(role!='Role'&&role!='Member') {
     isAdmin=true;
   }

   await _firebaseHelper.userRegister(userModel,isAdmin).then((value) {
     isAdded=value.entries.first.key;
     addMemberMsg=value.entries.first.value;
   });

   isLoading=false;
   notifyListeners();
 }
 List<String>committeesList=['Committee','HR','Media','PR','Events','HighBoard','Marketing','FR','AC','Platform'];
 List<String>rolesList=['Role','Head','Vice Head','President','Vice President','OM','Member'];

}