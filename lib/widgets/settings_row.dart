import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';

import '../../../core/utils/app_color.dart';
class SettingsRow extends StatelessWidget {
  SettingsRow({Key? key,
    required this.text, required this.icon,this.onTap}) : super(key: key);
  void Function()? onTap;
  final String text;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Row(
          children: [

            icon,
            const SizedBox(width: 8,),
            Text(text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppColor.primary),),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
