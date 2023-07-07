import 'package:flutter/material.dart';

import '../../models/event/event_model.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key,required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Text(event.title);
  }
}
