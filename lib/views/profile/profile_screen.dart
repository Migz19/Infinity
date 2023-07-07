import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.25),
                bottomRight:
                Radius.circular(MediaQuery.of(context).size.height*0.25),

              ),
            ),
            child: Column(
              children: [

              ],
            ),
          ),

        ],
      ),
    );
}
}
