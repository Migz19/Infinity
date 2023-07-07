import 'package:flutter/material.dart';
import 'package:infinity/views/admin_options/add_event/add_event_screen.dart';
import 'package:infinity/widgets/card_admin_options.dart';

import '../../core/utils/app_assets.dart';
import '../../core/utils/app_color.dart';
import 'add_member/add_member_screen.dart';

class AdminOptionsScreen extends StatelessWidget {
  const AdminOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Infinity",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColor.primary),
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
          Row(
            children: [
              GestureDetector(
                child: AdminCardOptions(
                    imageUrl: AppAssets.addMember,
                    title: "Add new member",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddMemberScreen()));
                    }),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                child: AdminCardOptions(
                    imageUrl: AppAssets.addMember,
                    title: "Add new event",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  AddEventScreen()));
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
