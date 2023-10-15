import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/utils/app_constants.dart';

class FirebaseStorageHandler {
  static FirebaseStorageHandler? _storageHandler;

  FirebaseStorageHandler._();

// Singleton
  factory FirebaseStorageHandler.instance() {
    _storageHandler ??= FirebaseStorageHandler._();
    return _storageHandler!;
  }

//Upload image and check the provided collection name and id
  Future<String> uploadImage({required File image,
    required id,
    required String collectionName}) async {
    String reference;
    if (collectionName == 'events') {
      reference = AppConstants.stEventPath;
    } else {
      reference = AppConstants.stProfilePath;
    }
    final ref = FirebaseStorage.instance.ref(reference).child("$id.jpg");
    ref
        .putFile(image)
        .whenComplete;
    return await ref.getDownloadURL();
  }

  //Access user profile image ( setter and getter ) by user id
  Future<String> addProfImg(File image, String userId) async {
    final ref = FirebaseStorage.instance.ref(AppConstants.stProfilePath).child("$userId.jpg");
    await ref.putFile(image).whenComplete;
    return await ref.getDownloadURL();
  }

  Future<Reference> getProfImg(String userId) async {
    return FirebaseStorage.instance
        .ref(AppConstants.stProfilePath)
        .child("$userId.jpg");
  }

  Future<String> addEventImg(File image, String eventID) async {
    final ref = FirebaseStorage.instance
        .ref(AppConstants.stEventPath)
        .child("$eventID.jpg");
    await ref
        .putFile(image)
        .whenComplete;
    return await ref.getDownloadURL();
  }
  //Upload List of Files to firestore to the desired collection and child ID and
  // return List of download URLs
  Future<List<String>> uploadFiles(List<File> files, String reference,
      String childID) async {
    int count = 0;
    List<String> filesUrls = [];
    final ref =  FirebaseStorage.instance.ref(reference).child(childID);
    for (var element in files) {
      await ref.child("File $count").putFile(element);
      count++;
    }
    ListResult filesList=await ref.listAll() ;
    for(var element in filesList.items){
      String downloadUrl=await element.getDownloadURL();
      filesUrls.add(downloadUrl);
      print("999999999 $downloadUrl");
    }

    return await filesUrls;
  }

    }
