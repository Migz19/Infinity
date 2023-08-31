import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/views/onboarding/welcome_screen.dart';
import 'package:infinity/widgets/custom_type_button.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_assets.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email="5645";

  @override
  Widget build(BuildContext context) {
    setState(() {
    context.watch<ProfileProvider>().getUserEmail().then((value) {
      email=value.toString();
    });
    });


    return Scaffold(

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(MediaQuery.of(context).size.height * 0.25),
                bottomRight:
                    Radius.circular(MediaQuery.of(context).size.height * 0.25),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: context.height * 0.3,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              context.read<ProfileProvider>().imageNotNull
                                  ? FileImage(
                                      context.watch<ProfileProvider>().profImg!)
                                  : null,
                        ),
                        Column(
                          children: [
                            TextButton(
                              onPressed: () =>
                                  _displayPickImageDialogue(context),
                              child: const Text(
                                "Add image",
                                style: TextStyle(fontSize: 10),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                     email ,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  const Text(

                    'Email',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  CustomTypeButton(
                    text: "Log out",
                    width: 90,
                    buttonColor: AppColor.primary.withOpacity(0.7),
                    textColor: Colors.white,
                    onTap: () {
                      remove();
                      AppNavigator.customNavigator(
                          context: context,
                          screen: WelcomeScreen(),
                          finish: true);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void remove() {
    CacheHelper.clear();
  }

  Future _displayPickImageDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: context.height * 0.7,
            alignment: Alignment.bottomCenter,
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              title: const Text(
                "Choose where to pick image from",
                style: TextStyle(fontSize: 15),
              ),
              content: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .fetchImage("camera");
                            Navigator.pop(context);
                          },
                          focusColor: Colors.grey,
                          icon: Image.asset(AppAssets.cameraIcon)),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Camera",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            context
                                .read<ProfileProvider>()
                                .fetchImage("gallery");
                            Navigator.pop(context);
                          },
                          focusColor: Colors.grey,
                          icon: Image.asset(AppAssets.galleryIcon)),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Gallery",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
