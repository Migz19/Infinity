import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';

import '../custom_type_button.dart';

class WelcomeBottomSheet extends StatelessWidget {
  const WelcomeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.5,
      color: AppColor.primary,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          CustomTypeButton(
            text: "Admin",
            isLoading: false,
            textColor: Colors.white,
            buttonColor:AppColor.primary.withOpacity(0.7),

            onTap: () async {




            },),
          const SizedBox(height: 16,),
          CustomTypeButton(
            text: "Member",
            isLoading: false,
            textColor: Colors.white,
            buttonColor:AppColor.primary.withOpacity(0.7),

            onTap: () async {




            },),
        ],
      ),
    );
  }
}
