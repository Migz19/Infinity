import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/models/event/event_model.dart';

import '../../../core/utils/app_assets.dart';
import '../firebase_helper.dart';
import 'firebase_storage_handler.dart';

class EventsHandler {
  Future<bool> addNewEvent(EventModel model) async {
    model.id=generateRandomDocId();
    if (model.eventFiles != null) {
      model.imagesUrls=await FirebaseStorageHandler.instance().uploadFiles(
          model.eventFiles!, AppAssets.stEventPath, model.id);
    }
     await FirebaseHelper().addEvent(model).then((value) {
      return true;
    });
    return false;
  }
  }


