import 'package:flutter/material.dart';
import 'package:infinity/views/admin_options/add_event/add_event_screen.dart';
import 'package:infinity/views/admin_options/add_member/add_member_screen.dart';
import 'package:infinity/views/admin_options/add_post/add_post_screen.dart';
import 'package:infinity/views/admin_options/remove_event/remove_event.dart';
import 'package:infinity/views/admin_options/remove_post/remove_post.dart';
import 'package:infinity/widgets/naviagtion.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_color.dart';
import '../committees/widgets/committee_card.dart';

class AdminOptionsScreen extends StatelessWidget {
  Map<int, MapEntry<String, String>> adminOptionsMap = {
    1: MapEntry("Add a new member", AppAssets.addMember),
    2: MapEntry("Add a new event", AppAssets.addEvent),
    3:MapEntry("Add a new Post",AppAssets.addPost),
    4: MapEntry("Remove a member", AppAssets.removeMember),
    5: MapEntry("Cancel an event", AppAssets.cancelEvent),
    6: MapEntry("Remove a post", AppAssets.removePost),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: Text(
          "Admin Options Panel",
          textAlign: TextAlign.start,
          style:
          TextStyle(fontWeight: FontWeight.w500, color: AppColor.primary,fontSize: 15),
        ),
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
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              children: adminOptionsMap.entries.map((entry) {
                final title = entry.value.key;
                final index= entry.key;
                final imageUri = entry.value.value;
                return GridTile(
                  child: GestureDetector(
                    child: CustomCard(title, imageUri),
                    onTap: () {
                      openAdminOption(index,context);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void openAdminOption(int index,BuildContext context) {
    late Widget destination;
    switch (index) {
      case 1: destination=const AddMemberScreen();
      break;
      case 2: destination=AddEventScreen();
      break;
      case 3 : destination=const AddPostScreen();
      break;
      case 4: destination=const RemoveEventScreen();
      break;
      case 5: destination=const RemovePostScreen();
      break;
    }
    AppNavigator.customNavigator(context: context, screen: destination, finish: false);
  }
}
