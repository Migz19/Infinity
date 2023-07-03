import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:infinity/models/user/user_model.dart';

class FirebaseHelper{
  static  FirebaseHelper? _firebaseHelper;
   Map<String,dynamic>admin={};
  FirebaseHelper._();

  factory FirebaseHelper() {
    _firebaseHelper ??= FirebaseHelper._();
    return _firebaseHelper!;
  }

  Future<bool> UserRegister(UserModel user) async {

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: user.email, password: user.password)
        .then((value) {
      user.id = value.user!.uid;
      return _UserCreate(user, value.user!.uid);

      //   return true;
    }).catchError((error) {
       return false;
    });
    return false;
  }

  Future<bool> _UserCreate(UserModel user, String UId) async {
    user.id = UId;
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(UId)
          .set(user.toJson())
          .then((value) {
            print("User added  $UId");
        return true;
      });
    }catch(error){
      print(error);
      return false;
    }
    return false;
  }





UserModel ?userModel;




  Future<dynamic> getUserData({required String UId, required String collectionName})
  async {
    try {
      print("getUserData");
      DocumentSnapshot<Map<String, dynamic>> value= await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(UId)
          .get();
          print("${value.data()}");
          if(collectionName=='admin')
          admin=value.data()!;
          else {
            userModel=UserModel.fromJson(json: value.data()!);
          }
        return value;

    } catch (error) {
      print("error1: ${error}");
      return error;
    }
  }


}