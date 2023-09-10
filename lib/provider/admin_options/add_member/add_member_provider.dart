import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/data/remote/helpers/notification_handler.dart';
import 'package:infinity/models/user/user_model.dart';

class AddMemberProvider extends ChangeNotifier{
 FirebaseHelper  _firebaseHelper=FirebaseHelper();
 NotificationHandler notificationHandler=NotificationHandler();
 bool? isLoading;
 bool isAdded=false;
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

   isAdded =await _firebaseHelper.userRegister(userModel,isAdmin);

   isLoading=false;
   notifyListeners();
 }
 List<String>committeesList=['Committee','HR','Media','PR','Events','HighBoard','Marketing','FR','AC','Platform'];
 List<String>rolesList=['Role','Head','Vice Head','Highboard','Member'];

}