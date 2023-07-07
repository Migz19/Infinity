import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/home/home_provider.dart';
import 'package:infinity/views/add_member/add_member_screen.dart';
import 'package:infinity/views/events/event_details_screen.dart';
import 'package:infinity/views/events/events_screen.dart';
import 'package:infinity/widgets/home/custom_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Container(
          height: context.height*0.6,
          child: provider.upcomingEvents.isNotEmpty
              ? ListView.separated(
                  itemCount: provider.upcomingEvents.length,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: FixedExtentScrollController(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context1, index) => CustomCard(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventDetailsScreen(
                                  event: provider.upcomingEvents[index]),
                            ));
                      },
                      width: context.width,
                      height: context.height,
                      imageUri: AppAssets.backgroundLogo,
                      title: provider.upcomingEvents[index].title,
                      date: provider.upcomingEvents[index].date,
                      iconData: Icons.bookmark,
                      iconVisibility: true),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                )
              : CustomCard(
                  width: context.width,
                  height: context.width,
                  imageUri: AppAssets.addMember,
                  title: "No Events",
                  iconVisibility: false,
                  onPressed: null,
                ),
        ),
      ),
    );
  }
}
