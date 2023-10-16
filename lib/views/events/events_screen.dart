import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/events/events_provider.dart';
import 'package:provider/provider.dart';

import '../../models/event/event_model.dart';
import 'widgets/event_list.dart';

class EventScreen extends StatefulWidget {

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List<EventModel> eventsList = [];
  @override
  void initState() {
    super.initState();
    getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: AppColor.tertiary),
        ),
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: context.width,
        height: context.height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: EventsList(eventList: eventsList),
      ),
    );
  }
  Future<void>getAllEvents()async{
    await context.read<EventsProvider>().getAllEvents();

    setState(() {
      eventsList =  context.read<EventsProvider>().allEventsList;
    });
  }
}