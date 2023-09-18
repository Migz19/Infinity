import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/models/event/event_model.dart';

import '../../../core/utils/app_assets.dart';
import '../firebase_helper.dart';
import 'firebase_storage_handler.dart';

class EventsHandler {
  static List<QueryDocumentSnapshot<Map<String, dynamic>>>? eventsSnapshotDocs;

  Future<bool> addNewEvent(EventModel model) async {
    model.id = generateRandomDocId();
    if (model.eventFiles != null) {
      model.filesUrls = await FirebaseStorageHandler.instance()
          .uploadFiles(model.eventFiles!, AppAssets.stEventPath, model.id);
    }
    await FirebaseHelper().addEvent(model).then((value) {
      return true;
    });
    return false;
  }

  Future<List<EventModel>> getAllEvents() async {
    List<EventModel> events = [];
    eventsSnapshotDocs ??= await FirebaseHelper().getAllItems(AppAssets.fsEventPath);
    if (eventsSnapshotDocs!.isNotEmpty) {
      for (var eventSnapshot in eventsSnapshotDocs!) {
        EventModel model = EventModel.fromJson(json: eventSnapshot.data());
        model.date = model.date.substring(0, 10);
        events.add(model);
      }
    }

    return events;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    List<EventModel> upcomingEvents = [];
    await getAllEvents();
    if (eventsSnapshotDocs!.isNotEmpty) {
      for (var eventSnapshot in eventsSnapshotDocs!) {
        EventModel model = EventModel.fromJson(json: eventSnapshot.data());

        if (DateTime.parse(model.date).isAfter(DateTime.now())) {
          model.date = model.date.substring(0, 10);
          upcomingEvents.add(model);
        }
      }
    }

    return upcomingEvents;
  }

}
