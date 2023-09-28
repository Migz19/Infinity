import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/data/remote/helpers/event_handler.dart';
import 'package:infinity/models/event/event_model.dart';

import '../../../controller/custom_file_picker.dart';
import '../../../controller/custom_image_picker.dart';


class AddEventProvider extends ChangeNotifier {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  bool? isLoading;
  bool isAdded = false;
  bool addFilesState = false;

  CustomImagePicker imagePicker = CustomImagePicker();

  Future<void> addNewEvent({
    required EventModel eventModel
  }) async {
    isLoading = true;
    notifyListeners();

    isAdded = await EventsHandler().addNewEvent(eventModel);
    print("isAdded : ${isAdded}");

    isLoading = false;
    notifyListeners();
  }

  Future<List<File>?> pickFiles() async {
    addFilesState = true;
    isLoading = true;
    notifyListeners();

    List<File>?imageFiles = await CustomFilePicker().pickMultipleImages();
    isLoading = false;
    addFilesState = false;
    notifyListeners();
    return imageFiles;
  }



}
