import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinity/models/user/user_model.dart';

class FirebaseHelper{
  static  FirebaseHelper? _firebaseHelper;
  FirebaseHelper._();

  factory FirebaseHelper() {
    _firebaseHelper ??= FirebaseHelper._();
    return _firebaseHelper!;
  }

  Future<bool> UserRegister(UserModel user) async {

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: user.email!, password: user.password!)
        .then((value) {

      user.id = value.user!.uid;
      return UserCreate(user, value.user!.uid);

      //   return true;
    }).catchError((error) {
       return false;
    });
    return false;
  }

  Future<bool> UserCreate(UserModel user, String UId) async {
    user.id = UId;
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UId)
          .set(user.toJson())
          .then((value) {
        return true;
      });
    }catch(error){
      return false;
    }
    return false;
  }










  Future<dynamic> getUserData(String UId) async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(UId)
          .get()
          .then((value) {
        return UserModel.fromJson(json: value.data()!);
      });
    } catch (error) {
      return error;
    }
  }


}