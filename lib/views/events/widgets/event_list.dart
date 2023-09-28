import 'package:flutter/material.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/views/events/widgets/event_card.dart';
import 'package:infinity/views/events/widgets/event_details_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../../provider/login_type/login_type_provider.dart';

class EventsList extends StatelessWidget {
  const EventsList({Key? key, required this.eventList}) : super(key: key);
  final List<EventModel> eventList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10.0,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            eventList.length,
            (index) => GestureDetector(
              child: EventCard(
                event: eventList[index],
              ),
              onTap: () {
                AppNavigator.customNavigator(
                  context: context,
                  screen: EventDetailsScreen(
                    event: eventList[index],
                  ),
                  finish: false,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
