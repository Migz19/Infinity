import 'dart:io';

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
  bool addFilesState=false;

  CustomImagePicker imagePicker=CustomImagePicker();
  Future<void> addNewEvent({
    required String title,
    required String description,
    required String location,
    required String date,
  }) async {
    isLoading = true;
    notifyListeners();
    EventModel eventModel= EventModel(title: title,  date: date, location: location, description: description);
    isAdded = await EventsHandler().addNewEvent(eventModel);
    isLoading = false;
    notifyListeners();
  }
  Future<List<File>?> pickFiles ()async{
    notifyListeners();
     addFilesState=true;
    List<File>?imageFiles=await CustomFilePicker().pickMultipleImages();
    addFilesState=false;
    notifyListeners();
    return imageFiles;
  }
}
