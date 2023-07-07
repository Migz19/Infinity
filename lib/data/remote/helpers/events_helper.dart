import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/event/event_model.dart';

class EventsHelper {
  static EventsHelper? _eventsHelper;

  EventsHelper._();

  var db = FirebaseFirestore.instance;

  factory EventsHelper() {
    _eventsHelper ??= EventsHelper._();
    return _eventsHelper!;
  }

  Future<bool> addEvent(EventModel event) async {
    try {
      db.collection('events').doc(eventID).set(event.toJson()).then((value) {
        print("Event ${eventID} is added successfully");
        return true;
      });
    } catch (error) {
      print("Error getting events");
    }
    return false;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    List<EventModel> eventsList = [];
    try {
      db
          .collection("events")
          .where((int.parse("date") > 10), isEqualTo: true)
          .get()
          .then(
            (querySnapshot) {
          print("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            eventsList.add(EventModel.fromJson(json: docSnapshot.data()));
          }
        },
        onError: (e) => print("Error completing: $e"),
      );
    } catch (error) {
      print("Error getting events");
    }
    return eventsList;
  }

  Future<List<EventModel>> getAllEvents() async {
    List<EventModel> eventsList = [];
    try {
      db
          .collection("events")
          .where((int.parse("date") > 10), isEqualTo: true)
          .get()
          .then((querySnapshot) {
        print("Got Events");
        for (var docSnapshot in querySnapshot.docs) {
          eventsList.add(EventModel.fromJson(json: docSnapshot));
        }
      }, onError: (e) => print("Error fetching data $e"));
    } catch (error) {
      print("Error getting events");
    }
    return eventsList;
  }
}
