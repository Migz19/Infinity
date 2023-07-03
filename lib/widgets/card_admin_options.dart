import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';

class AdminCardOptions extends StatelessWidget {
  String imageUrl;
  String title;

  VoidCallback onTap;

  AdminCardOptions(
      {required this.imageUrl,
      required this.title,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
    onTap: onTap,
      child: SizedBox(
        width: context.width * 0.3,
        height: context.height * 0.2,
        child: Stack(
          children: [
            Image.asset(imageUrl, fit: BoxFit.fill),
            Container(
              decoration:
                  BoxDecoration(color: AppColor.primary.withOpacity(0.2)),
              height: context.height * 0.04,
              //alignment: Alignment.center,
              margin: EdgeInsets.only(top: context.height * 0.14),
            ),
            Flexible(
                child: Text(
              textAlign: TextAlign.center,
              title,
              style: const TextStyle(color: Colors.white),

            )),
          ],
        ),
      ),
    );
  }
}
