import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/event/event_model.dart';
import 'package:infinity/provider/events/events_provider.dart';
import 'package:infinity/views/events/widgets/media_details.dart';
import 'package:infinity/widgets/dynamic_text_widget.dart';
import 'package:infinity/widgets/toast/enum.dart';
import 'package:infinity/widgets/toast/toast.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({Key? key, required this.event}) : super(key: key);
  final EventModel event;

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late EventModel _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
    print("349085098340985934850${_event.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const Text(
          "Event Details",
          style: TextStyle(color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: context.height * 0.4,
                leading: Container(),
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  background: MediaDetails(
                    images: _event.filesUrls,
                    eventID: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          _event.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DynamicTextWidget(
                              length: 150,
                              text: _event.description.isEmpty
                                  ? 'No Description'
                                  : _event.description,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    _event.location,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timelapse,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Expanded(
                                  child: Text(
                                    _event.date,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
         FirebaseHelper().admin.isNotEmpty? Positioned(
              bottom: 50,
              right: 20,
              child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {

                    if ( context
                        .read<EventsProvider>()
                        .deleteEvent(_event.id)
                        .isNotEmpty) {

                      ToastConfig.showToast(
                          context: context,
                          msg: context.read<EventsProvider>().isEventDeleted.entries.first.value,
                          toastStates: context
                                  .read<EventsProvider>()
                                  .isEventDeleted
                                  .entries
                                  .first
                                  .key
                              ? ToastStates.Success
                              : ToastStates.Error);
                    }
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 35,
                  ))):SizedBox(),
        ],
      ),
    );
  }
}
