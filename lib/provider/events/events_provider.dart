import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

import '../../models/event/event_model.dart';

class EventsProvider extends ChangeNotifier {
  late List<EventModel> upcomingEvents;
  late List<EventModel> pastEvents;
  FirebaseHelper firebaseHelper = FirebaseHelper();

  Future<List<EventModel>> getUpcomingEvents()async {
   return await firebaseHelper.getUpcomingEvents().then((value) => upcomingEvents);
  }
  Future<List<EventModel>>getAllEvents()async {
   return await firebaseHelper.getAllEvents().then((value) => pastEvents);
  }
}
