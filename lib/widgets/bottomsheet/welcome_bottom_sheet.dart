import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/provider/login_type/login_type_provider.dart';
import 'package:infinity/views/navigation/navigation_screen.dart';
import 'package:infinity/widgets/naviagtion.dart';
import 'package:provider/provider.dart';

import '../../views/auth/login/login_screen.dart';
import '../custom_type_button.dart';

class WelcomeBottomSheet extends StatelessWidget {
  const WelcomeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.4,
      width: context.width,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox( width: context.width*0.6,
              child:const Padding(
                padding:  EdgeInsets.symmetric(vertical: 18.0),
                child: Text(
                  maxLines: 2,"Welcome Infinity Club",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,),
                ),
              ),
            ),
            CustomTypeButton(
              text: "Admin",
              isLoading: context.watch<LoginTypeProvider>().isLoading,
              textColor: Colors.white,
              buttonColor:AppColor.primary.withOpacity(0.7),
              onTap: () async {
                context.read<LoginTypeProvider>().setLoginType(loginType: 1);
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },),
            CustomTypeButton(
              text: "Member",
              isLoading: context.watch<LoginTypeProvider>().isLoading,
              textColor: Colors.white,
              buttonColor:AppColor.primary.withOpacity(0.7),

              onTap: () async {
                context.read<LoginTypeProvider>().setLoginType(loginType: 2);
                AppNavigator.customNavigator(context: context, screen: LoginScreen(), finish: false);
              },),
            CustomTypeButton(
              text: "Visitor",
              isLoading: false,
              textColor: Colors.white,
              buttonColor:AppColor.primary.withOpacity(0.7),
              onTap: () async {
                context.read<LoginTypeProvider>().setLoginType(loginType: 3);
                AppNavigator.customNavigator(context: context, screen: NavigationScreen(), finish: true);
              },),
          ],
        ),
      ),
    );
  }
}
