import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/post/post_model.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/views/events/widgets/event_details_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../models/event/event_model.dart';
import '../../provider/events/events_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EventModel> events = [];
  List<PostModel> announcements = [];

  @override
  void initState() {
    super.initState();
    getUpcomingEvents();
    getAllPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Upcoming Events',
                style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: events.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 3,
                indent: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Text(
                      events[index].title,
                      style: TextStyle(
                          color: AppColor.second, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: context.width * 0.55,
                      margin: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: CachedNetworkImage(
                              imageUrl: events[index].filesUrls.first,
                              width: 300,
                              height: 100,
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.second.withOpacity(0.5)),
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Text(events[index].date.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Announcements',
                style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 5,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: context.height * 0.4,
                  width: context.width * 0.3,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          announcements[index].postDetails.toString(),
                          maxLines: 7,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        CachedNetworkImage(
                            height: context.height * 0.3,
                            imageUrl:
                                announcements[index].filesDownloadUrl.first,
                            alignment: Alignment.center,
                            fit: BoxFit.contain),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUpcomingEvents() async {
    await context.read<EventsProvider>().getUpcomingEvents().whenComplete(() {
      context.read<EventsProvider>().notifyListeners();
      setState(() {
        events = context.read<EventsProvider>().upComingEvents;
      });

    });

  }

  Future<void> getAllPosts() async {
    await context.read<HomeProvider>().getAllPosts().whenComplete(() {
      context.read<HomeProvider>().notifyListeners();
      setState(() {
        announcements = context.read<HomeProvider>().postsList;
      });
    });
  }
}
