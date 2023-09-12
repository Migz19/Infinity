import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/helpers/event_handler.dart';
import 'package:infinity/models/event/event_model.dart';


class EventsProvider extends ChangeNotifier {

 Future<List<EventModel>>getAllEvents()async{
   List<EventModel> eventsList=[];
   eventsList =await EventsHandler().getAllEvents().then((value) => eventsList);

    notifyListeners();
return  eventsList;
  }
  Future<void> getUpcomingEvents()async{

  }
}
