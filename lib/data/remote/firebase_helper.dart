import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:infinity/data/remote/helpers/event_handler.dart';
import 'package:infinity/data/remote/helpers/firebase_storage_handler.dart';
import 'package:infinity/data/remote/helpers/posts_handler.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/models/post/post_model.dart';
import 'package:infinity/models/user/user_model.dart';

class FirebaseHelper {
  static FirebaseHelper? _firebaseHelper;

  Map<String, dynamic> admin = {};

  FirebaseHelper._();

  factory FirebaseHelper() {
    _firebaseHelper ??= FirebaseHelper._();

    return _firebaseHelper!;
  }

  Future<bool> userRegister(UserModel user, bool isAdmin) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email, password: user.password)
        .then((value) {
      user.id = value.user!.uid;
      if (isAdmin) {
        return _createAdmin(user, value.user!.uid);
      } else {
        return _createUser(user, value.user!.uid);
      }
    });
    return false;
  }

  Future<bool> _createUser(UserModel user, String uId) async {
    user.id = uId;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(user.toJson())
          .then((value) {
        print("User added  $uId");
      });
      await FirebaseFirestore.instance
          .collection("committees")
          .doc(user.committee)
          .update({
        "members_ids": FieldValue.arrayUnion([user.id])
      }).then((value) {
        return true;
      });
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  Future<bool> _createAdmin(UserModel user, String uId) async {
    user.id = uId;
    try {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(uId)
          .set(user.toJson())
          .then((value) {
        print("Admin added  $uId");
        return true;
      });
    } catch (error) {
      print(error);
      return false;
    }
    return false;
  }

  UserModel? userModel;

  Future<dynamic> getUserData(
      {required String UId, required String collectionName}) async {
    try {
      print("getUserData");
      DocumentSnapshot<Map<String, dynamic>> value = await FirebaseFirestore
          .instance
          .collection(collectionName)
          .doc(UId)
          .get();
      print("*/*/*/*/*/${value.data()}");
      if (collectionName == 'admin') {
        admin = value.data()!;
      }
      userModel = UserModel.fromJson(json: value.data()!);
      return value.data();
    } catch (error) {
      print("error1: ${error}");
      return error;
    }
  }

  Future<void> userLogOut() async {
    userModel = null;
    await FirebaseAuth.instance.signOut();
  }

//upload profile image and save url to user collection
  Future<void> uploadProfileImage(File file) async {
    String collectionName;
    if (userModel?.role == "member") {
      collectionName = "users";
    } else {
      collectionName = "admin";
    }
    uploadImage(
        imageFile: file,
        collectionName: collectionName,
        docId: FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> uploadImage(
      {required File imageFile,
      required String collectionName,
      String? docId}) async {
    final image_url = await FirebaseStorageHandler.instance().uploadImage(
        image: imageFile, id: docId, collectionName: collectionName);
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docId)
        .update({"photo": image_url});
  }

  Future<Reference> fetchProfileImage() async {
    return await FirebaseStorageHandler.instance()
        .getProfImg(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> addEvent(EventModel model) async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(model.id)
        .set(model.toJson());

    try {
      await FirebaseFirestore.instance
          .collection("events")
          .doc(model.id)
          .update({
        'Files urls': model.filesUrls,
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> addPost(PostModel model) async {
    await FirebaseFirestore.instance.collection("posts").doc(model.postId).set({
      'Post details': model.postDetails,
    });

    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(model.postId)
          .update({
        'Files url': model.filesDownloadUrl,
      });
    } catch (error) {
      print(error);
    }
  }

  Future<String> deleteDocument(String collectionName, String docID) async {
    try {
      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(docID)
          .delete()
          .whenComplete;
    } catch (error) {
      return error.toString();
    }
    return "$collectionName deleted successfully";
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllItems(
      String collectionPath) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .get()
        .then((querySnapshot) async {
      return await querySnapshot.docs.toList();
    });
  }

  Future<Map<String, dynamic>?> getDocument(
      String collectionName, String docID) async {
    try {
      await FirebaseFirestore.instance
          .collection("Committees")
          .doc(docID)
          .get()
          .then((querySnapShot) async {
        if (querySnapShot.exists) {
          return await querySnapShot.data();
        }
      });
    } catch (error) {
      return null;
    }
  }
}
