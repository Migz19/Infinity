import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/helpers/event_handler.dart';
import 'package:infinity/models/event/event_model.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> allEventsList = [];
  List<EventModel> upComingEvents = [];

  Future<List<EventModel>> getAllEvents() async {
    allEventsList = await EventsHandler().getAllEvents();
    notifyListeners();
    return allEventsList;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    upComingEvents = await EventsHandler().getUpcomingEvents();

    notifyListeners();
    return upComingEvents;
  }
}
