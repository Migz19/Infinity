import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

class FCMToken{
  FirebaseHelper _helper=FirebaseHelper();
  Future<void>addToken({required String fcmToken})
  async{
   try{

     await FirebaseFirestore.instance
         .collection('token').doc(fcmToken).set({
       "fcm_token":fcmToken,
     }).then((value) {
     //  print("Token added  ${value}");
     });
   }catch(error)
    {
      print("error : "+error.toString());
    }
  }
}