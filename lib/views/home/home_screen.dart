import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/controller/converters.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/post/post_model.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/provider/navigator/navigator_provider.dart';
import 'package:infinity/views/events/widgets/event_details_screen.dart';
import 'package:infinity/views/posts/post_details_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_constants.dart';
import '../../models/event/event_model.dart';
import '../../provider/events/events_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        shadowColor: Colors.black38,
        title: Text(
          context
              .watch<NavigatorProvider>()
              .screenTitles[context.read<NavigatorProvider>().currentIndex],
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: AppColor.primary),
        ),
        toolbarHeight: context.height * 0.08,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Image.asset(
              AppAssets.logo,
              width: 100,
              height: 100,
              alignment: Alignment.topRight,
            ),
          ),
        ],
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
            child: FutureBuilder<List<EventModel>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (context
                        .read<EventsProvider>()
                        .upComingEvents
                        .isNotEmpty) {
                      print("snapshot has data ");
                      return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: context
                            .read<EventsProvider>()
                            .upComingEvents
                            .length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 3,
                          indent: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              AppNavigator.customNavigator(
                                  context: context,
                                  screen: EventDetailsScreen(
                                      event: context
                                          .read<EventsProvider>()
                                          .upComingEvents[index]),
                                  finish: false);
                            },
                            child: Container(
                              width: context.width * 0.45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColor.second)),
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: context
                                                .read<EventsProvider>()
                                                .upComingEvents[index]
                                                .filesUrls
                                                .isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: context
                                                    .read<EventsProvider>()
                                                    .upComingEvents[index]
                                                    .filesUrls
                                                    .first,
                                                width: 300,
                                                height: 100,
                                              )
                                            : Image.asset(
                                                AppAssets.logo,
                                                width: 300,
                                                height: 100,
                                              ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColor.second
                                                .withOpacity(0.4)),
                                        alignment: Alignment.center,
                                        width: 60,
                                        height: 50,
                                        child: Text(
                                         getDateInSpecialFormat(context
                                             .read<EventsProvider>()
                                             .upComingEvents[index]
                                             .date),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'Actor',
                                            fontWeight: FontWeight.w400,

                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    context
                                        .read<EventsProvider>()
                                        .upComingEvents[index]
                                        .title,
                                    style: TextStyle(
                                      fontSize: 15,
                                        overflow: TextOverflow.ellipsis,
                                        color: AppColor.second,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      print("snapshot doesn't have data ");
                      return Column(
                        children: [
                          Image.asset(
                            AppAssets.notFoundIcon,
                            width: 40,
                            height: 40,
                          ),
                          SizedBox(),
                          Text("No Upcoming Events"),
                        ],
                      );
                    }
                  } else {
                    print("connection state failed");
                    return Container(
                      height: 40,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.notFoundIcon,
                              width: context.width * 0.1),
                          Text(
                            AppConstants.noDataCheckConnection,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: AppColor.second, fontSize: 15),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  );
                }
              },
              future: getUpcomingEvents(),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18,
            ),
            child: Text('Announcements',
                style: TextStyle(
                    color: AppColor.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 6,
            child: FutureBuilder<List<PostModel>>(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: context.read<HomeProvider>().postsList.length,
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
                          child: GestureDetector(
                            child: Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    context
                                        .read<HomeProvider>()
                                        .postsList[index]
                                        .postDetails,
                                    maxLines: 7,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: context
                                            .read<HomeProvider>()
                                            .postsList[index]
                                            .filesDownloadUrl
                                            .isNotEmpty
                                        ? CachedNetworkImage(
                                            height: context.height * 0.2,
                                            imageUrl: context
                                                .read<HomeProvider>()
                                                .postsList[index]
                                                .filesDownloadUrl
                                                .first,
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain)
                                        : const SizedBox(
                                            height: 0,
                                            width: 0,
                                          ),
                                  )
                                ],
                              ),
                            ),
                            onTap: (){

                              AppNavigator.customNavigator(
                                context: context,
                                screen: PostDetailsScreen(
                                   post:  context.read<HomeProvider>()
                                       .postsList[index],

                                ),
                                finish: false,
                              );
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 35,
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.notFoundIcon,
                            width: context.width * 0.3),
                        SizedBox(
                          height: context.height * 0.1,
                        ),
                        Text(
                          AppConstants.noDataCheckConnection,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: AppColor.second, fontSize: 20),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: AppColor.primary),
                  );
                }
              },
              future: getAllPosts(),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<PostModel>> getAllPosts() async {
    return await context.read<HomeProvider>().getAllPosts();
  }

  Future<List<EventModel>> getUpcomingEvents() async {
    return await context.read<EventsProvider>().getUpcomingEvents();
  }
}
