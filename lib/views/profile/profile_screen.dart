import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/user/user_model.dart';
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
  UserModel? currentUser;
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    fetchUserData().then((value) {
      setState(() {
        widget.currentUser = context.read<ProfileProvider>().currentUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: context.watch<ProfileProvider>().isLoading
          ? const Center(child: CircularProgressIndicator())
          : context.read<ProfileProvider>().currentUser != null
              ? Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                              MediaQuery.of(context).size.height * 0.5),
                          bottomRight: Radius.circular(
                              MediaQuery.of(context).size.height * 0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: context.height * 0.2,
                          left: context.width * 0.35,
                          right: context.width * 0.3),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(children: [
                              CircleAvatar(
                                backgroundColor: AppColor.primary,
                                radius: 70,

                                child: widget.currentUser!.photo != null &&
                                        widget.currentUser!.photo!.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: widget.currentUser!.photo!,
                                      )
                                    : Image.asset(
                                        AppAssets.logo,
                                        color: Colors.white,
                                      ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 12,
                                child: GestureDetector(
                                  onTap: () =>
                                      _displayPickImageDialogue(context),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(Icons.edit, size: 18),
                                  ),
                                ),
                              )
                            ]),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                widget.currentUser!.username,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                            ),
                            Text(
                              widget.currentUser!.email,
                              style: const TextStyle(
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
                                context.read<ProfileProvider>().logout();
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
                )
              : Stack(
                  children: [
                    Container(
                      height: context.height,
                      width: context.width,
                      color: Colors.white,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            size: 100,
                            Icons.lock,
                            color: AppColor.primary,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: AppColor.primary,
                            child: ElevatedButton(
                                onPressed: () {
                                  AppNavigator.customNavigator(
                                      context: context,
                                      screen: WelcomeScreen(),
                                      finish: true);
                                },
                                child: const Text(
                                  "Login required \n Press to login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      wordSpacing: 3,
                                      height: 1.4),
                                )),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
    );
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
                                .uploadImage("camera");
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
                                .uploadImage("gallery");
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

  Future<UserModel?> fetchUserData() async {
    return await context.read<ProfileProvider>().getUserData();
  }
}
