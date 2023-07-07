import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/models/user/user_model.dart';

class AddMemberProvider extends ChangeNotifier{
  FirebaseHelper  _firebaseHelper=FirebaseHelper();
  bool? isLoading;
  bool isAdded=false;

  Future<void> addNewMember({required EventModel eventModel})
  async {
    isLoading=true;
    notifyListeners();
    //isAdded=await _firebaseHelper.addEvent(eventModel);
    isLoading=false;
    notifyListeners();
  }


}