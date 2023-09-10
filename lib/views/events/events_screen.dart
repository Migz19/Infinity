import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/event/event_model.dart';

import 'widgets/event_list.dart';

class EventScreen extends StatelessWidget {
 const EventScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(
          "Events",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500,color: AppColor.tertiary),
        ),
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: context.width,height: context.height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: EventsList(eventList: [
          EventModel(title: "Event Cairo",
              date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else."*20),
          EventModel(title: "Event Cairo",
             date: DateTime.now().toString(),
            location: "Cairo,Naser City",
            description: "But keeping them happy enough to come back is something else."*10),
          EventModel(title: "Event Cairo",
              date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),

          EventModel(title: "Event Cairo",
              date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),
          EventModel(title: "Event Cairo",
              date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),

        ]),
      ),

    );
  }


}
