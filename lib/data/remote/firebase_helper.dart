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

  Future<bool> userRegister(UserModel user,bool isAdmin) async {

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: user.email, password: user.password)
        .then((value) {
      user.id = value.user!.uid;
      if(isAdmin) {
        return _createAdmin(user, value.user!.uid);
      }else {
       return _createUser(user, value.user!.uid);
      }
    });
    return false;
  }

  Future<bool> _createUser(UserModel user, String uId) async {
    user.id = uId;
    try{
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(user.toJson())
          .then((value) {
            print("User added  $uId");
        return true;
      });
    }catch(error){
      print(error);
      return false;
    }
    return false;
  }
  Future<bool> _createAdmin(UserModel user, String uId) async {
    user.id = uId;
    try{
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(uId)
          .set(user.toJson())
          .then((value) {
        print("Admin added  $uId");
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
          if(collectionName=='admin') {
            admin = value.data()!;
          }
            userModel=UserModel.fromJson(json: value.data()!);
        return value;

    } catch (error) {
      print("error1: ${error}");
      return error;
    }
  }

Future <void>userLogOut()async{
    await FirebaseAuth.instance.signOut();
}
}