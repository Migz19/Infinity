import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/user/user_model.dart';
import 'package:infinity/provider/login_type/login_type_provider.dart';
import 'package:infinity/provider/profile/profile_provider.dart';
import 'package:infinity/views/onboarding/welcome_screen.dart';
import 'package:infinity/widgets/custom_type_button.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:infinity/widgets/settings_row.dart';
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
    if (context.read<LoginTypeProvider>().loginType != 3) {
      print("-------------->");
      fetchUserData().then((value) {
        widget.currentUser = context.read<ProfileProvider>().currentUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: context.watch<LoginTypeProvider>().loginType != 3
          ?isLoading? Container(height: context.height*0.01,width: context.width*0.01,child: CircularProgressIndicator(
        color: AppColor.primary,
      ),):Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.height * 0.25),
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.height * 0.25),
                    ),
                  ),
                ),
                Container(
                  color: AppColor.primary.withOpacity(0.2),
                  height: context.height,
                  padding: EdgeInsets.only(
                      top: context.height * 0.2,
                    left:8,right: 8,

                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70,
                            child: ClipOval(
                              child: SizedBox(
                                  height: 140,
                                  width: 140,
                                  child: widget.currentUser?.photo != null &&
                                          widget.currentUser!.photo!.isNotEmpty
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: widget.currentUser!.photo!)
                                      : Image.asset(
                                          AppAssets.logo,
                                          color: AppColor.primary,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 12,
                            child: GestureDetector(
                              onTap: () {
                                _displayPickImageDialogue(context);
                                setState(() {
                                  widget.currentUser = context
                                      .read<ProfileProvider>()
                                      .currentUser;
                                });
                              },
                              child:  CircleAvatar(
                                backgroundColor: AppColor.primary.withOpacity(0.8),
                                radius: 15,
                                child: Icon(Icons.edit, size: 18,color: Colors.white,),
                              ),
                            ),
                          )
                        ]),
                        const SizedBox(height: 16,),
                        SettingsRow(text:  widget.currentUser!.username, icon:
                          Icon( Icons.person,color: AppColor.primary,)),
                        const SizedBox(height: 8,),
                        SettingsRow(text:  widget.currentUser!.email, icon:
                        Icon( Icons.email,color: AppColor.primary,)),
                        const SizedBox(height: 8,),

                        SettingsRow(text:  widget.currentUser!.role, icon:
                        Icon( Icons.work,color: AppColor.primary,)),
                        const SizedBox(height: 8,),
                        SettingsRow(text:  widget.currentUser!.phoneNumber, icon:
                        Icon( Icons.phone,color: AppColor.primary,)),
                        const SizedBox(height: 8,),
                        SettingsRow(text:  widget.currentUser!.committee, icon:
                        Icon( Icons.cable,color: AppColor.primary,)),
                        CustomTypeButton(
                          text: "Log out",
                          width: context.width,

                          buttonColor: AppColor.primary.withOpacity(0.7),
                          textColor: Colors.white,
                          onTap: () async {
                            await context.read<ProfileProvider>().logout();
                            if (mounted) {
                              AppNavigator.customNavigator(
                                  context: context,
                                  screen: WelcomeScreen(),
                                  finish: true);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              alignment: Alignment.topCenter,
              children: [
                 Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColor.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                          MediaQuery.of(context).size.height * 0.25),
                      bottomRight: Radius.circular(
                          MediaQuery.of(context).size.height * 0.25),
                    ),
                  ),
                  child:const   Text("Visitor",style: TextStyle(
                    fontWeight: FontWeight.w600,color: Colors.white,fontSize: 30,
                  )),
                ),
                 Container(
                  color: AppColor.primary.withOpacity(0.2),
                  height: context.height,
                  padding: EdgeInsets.only(
                    top: context.height * 0.2,
                    left:8,right: 8,

                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 70,
                            child: ClipOval(
                              child: SizedBox(
                                  height: 140,
                                  width: 140,
                                  child:  Image.asset(
                                    AppAssets.logo,
                                    color: AppColor.primary,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),

                        ]),
                       const  SizedBox(height: 16,),
                        Text(
                          "You Must Know you are login as visitor"*20,
                        ),
                        CustomTypeButton(
                          text: "Login Now",
                          width: context.width*0.5,

                          buttonColor: AppColor.primary.withOpacity(0.7),
                          textColor: Colors.white,
                          radius: 25,

                          onTap: () async {
                            await context.read<ProfileProvider>().logout();
                            if (mounted) {
                              AppNavigator.customNavigator(
                                  context: context,
                                  screen: WelcomeScreen(),
                                  finish: true);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),

                     // Container(
                     //   color: AppColor.primary,
                     //   child: ElevatedButton(
                     //       onPressed: () async {
                     //         await context.read<ProfileProvider>().logout();
                     //         if (mounted) {
                     //           AppNavigator.customNavigator(
                     //               context: context,
                     //               screen: WelcomeScreen(),
                     //               finish: true);
                     //         }
                     //       },
                     //       child: const Text(
                     //         "Login required \n Press to login",
                     //         style: TextStyle(
                     //             color: Colors.white,
                     //             fontSize: 20,
                     //             wordSpacing: 3,
                     //             height: 1.4),
                     //       )),
                     // )
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
              alignment: Alignment.center,
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
                          onPressed: () async {
                            await context
                                .read<ProfileProvider>()
                                .uploadImage("camera");
                            if (mounted) {
                              Navigator.pop(context);
                            }
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
                          onPressed: () async {
                            await context
                                .read<ProfileProvider>()
                                .uploadImage("gallery");
                            if (mounted) {
                              Navigator.pop(context);
                            }
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

  bool isLoading = false;

  Future<UserModel?> fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    UserModel? model =await context
        .read<ProfileProvider>()
        .getUserData(context.read<LoginTypeProvider>().loginType);
    setState(() {
      isLoading = false;
    });
    return model;
  }
}
