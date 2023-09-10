import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:provider/provider.dart';

import '../../models/event/event_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

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
            child: Text('Upcoming Events',style: TextStyle(color: AppColor.primary,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: context.read<HomeProvider>().postsList.length,
              separatorBuilder: (BuildContext context,int index)=>const Divider(
                thickness: 3,indent: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      width: context.width*0.55,
                      margin: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: CachedNetworkImage(imageUrl: events[index].imagesUrls!.first,width: 300,height: 100,),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColor.second.withOpacity(0.5)),
                            padding: const EdgeInsets.only(top: 10,left: 10),
                            child: Text(events[index].date.toString(),style: const TextStyle(fontWeight: FontWeight.w400,color:Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Text(events[index].title,style: TextStyle(color: AppColor.second,fontWeight: FontWeight.w500),)
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('Announcements',style: TextStyle(color: AppColor.primary,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.right),
          ),
          Expanded(
            flex: 5,
            child: ListView.separated(

              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: context.read<HomeProvider>().postsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey,),color: Colors.white,borderRadius: BorderRadius.circular(10)),
                  height: context.height * 0.3,
                  width: context.width * 0.3,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(context
                                  .read<HomeProvider>()
                                  .postsList[index]
                                  .postDetails,maxLines: 7,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(AppAssets.logo,width: 60,height: 60,),

                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) =>Divider(
              height: 35,
            ),
            ),
          ),
        ],
      ),
    );
  }

  List<EventModel> events = [
    EventModel(
        title: "Event Cairo",

        date: DateTime.now().toString(),
        location: "Cairo,Naser City",
        description:
            "But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else." *
                20),
    EventModel(
        title: "Event Cairo",

        date: DateTime.now().toString(),
        location: "Cairo,Naser City",
        description:
            "But keeping them happy enough to come back is something else." *
                10),
    EventModel(
        title: "Event Cairo",
        date: DateTime.now().toString(),
        location: "Cairo,Naser City",
        description:
            "But keeping them happy enough to come back is something else." *
                10),
    EventModel(
        title: "Event Cairo",
        date: DateTime.now().toString(),
        location: "Cairo,Naser City",
        description:
            "But keeping them happy enough to come back is something else." *
                10),
    EventModel(
        title: "Event Cairo",
        date: DateTime.now().toString(),
        location: "Cairo,Naser City",
        description:
            "But keeping them happy enough to come back is something else." *
                10),
  ];
}
