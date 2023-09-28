import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/helpers/event_handler.dart';
import 'package:infinity/models/event/event_model.dart';

class EventsProvider extends ChangeNotifier {
  List<EventModel> allEventsList = [];
  List<EventModel> upComingEvents = [];
  Map<bool,String> isEventDeleted={};
  Future<List<EventModel>> getAllEvents() async {
    allEventsList = await EventsHandler().getAllEvents();
    notifyListeners();
    return allEventsList;
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    await EventsHandler().getUpcomingEvents().then((value) => upComingEvents);
    notifyListeners();
    return upComingEvents;
  }
  Map<bool,String> deleteEvent(String eventId){
     EventsHandler().removeEvent(eventId).then((value) {
       isEventDeleted=value;
       notifyListeners();
      return value;
    });
     notifyListeners();
  return {};
  }
}
