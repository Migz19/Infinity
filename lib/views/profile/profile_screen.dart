import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/data/local/cache_helper.dart';
import 'package:infinity/views/onboarding/welcome_screen.dart';
import 'package:infinity/widgets/custom_type_button.dart';
import 'package:infinity/widgets/naviagtion.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColor.second,
                      child: Image.asset(
                        AppAssets.logo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                       'Username',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  ),
                  Text(
                   'Email',
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
                    onTap:(){
                      remove();
                      AppNavigator.customNavigator(context: context, screen: WelcomeScreen(), finish: true);
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
  void remove(){
    CacheHelper.clear();
  }
}
