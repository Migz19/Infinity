import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/data/remote/notification_helper/notification_helper.dart';
import 'package:infinity/models/event/event_model.dart';

import '../../../core/utils/app_constants.dart';
import '../firebase_helper.dart';
import 'firebase_storage_handler.dart';

class EventsHandler {




  Future<bool> addNewEvent(EventModel model) async {
    model.id = generateRandomDocId();
    if (model.eventFiles != null) {
      model.filesUrls = await FirebaseStorageHandler.instance()
          .uploadFiles(model.eventFiles!, AppConstants.stEventPath, model.id);
    }

    await FirebaseHelper().addEvent(model).then((value) async {
      List<String> listOfTokens = [];
      FirebaseHelper().getAllItems('token');
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? SnapshotDocs =
          await FirebaseHelper().getAllItems('token');
      for (QueryDocumentSnapshot documentSnapshot in SnapshotDocs) {
        listOfTokens.add(documentSnapshot.id);
        print("isAdded : ${documentSnapshot.id}");
      }
      print("image${model.filesUrls[0]}");
      NotificationBaseHelper.sendNotificationToUsers(
        content: model.description,
        title: model.title,
        listOfTokens: listOfTokens,
        image: model.filesUrls[0],
      );
      return true;
    });
    return false;
  }

  Future<List<EventModel>> getAllEvents() async {
    List<EventModel> events = [];
    var eventsSnapshotDocs =
        await FirebaseHelper().getAllItems(AppConstants.fsEventPath);
    if (eventsSnapshotDocs.isNotEmpty) {
      for (var eventSnapshot in eventsSnapshotDocs) {
        EventModel model = EventModel.fromJson(json: eventSnapshot.data());
        model.date = model.date.substring(0, 10);
        events.add(model);
      }
    }

    return events;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    List<EventModel> upcomingEvents = [];
    var eventsSnapshotDocs =
    await FirebaseHelper().getAllItems(AppConstants.fsEventPath);
    if (eventsSnapshotDocs.isNotEmpty) {
      for (var eventSnapshot in eventsSnapshotDocs) {
        EventModel model =EventModel.fromJson(json: eventSnapshot.data());
        try {
          if (DateTime.parse(model.date).isAfter(DateTime.now())) {
            model.date = model.date.substring(0, 10);
            upcomingEvents.add(model);
          }
        }catch(error){
              continue;
        }
      }
    }
    return  upcomingEvents;
  }

  Future<Map<bool, String>> removeEvent(String eventId) async {
    return await FirebaseHelper().deleteDocument("events", eventId);
  }
}
