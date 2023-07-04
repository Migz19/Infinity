import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';

class CustomCard extends StatelessWidget {
  double width, height;
  String imageUri;
  String title;
  String? date;
  Function? onImagePressed;
  Function? onIconPressed;
  bool iconVisibility;
  IconData? iconData;


  CustomCard({required this.width,
    required this.height,
    required this.imageUri,
    required this.title,
    required this.iconVisibility,
    this.onIconPressed,
    this.onImagePressed,
    this.iconData,
    this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                imageUri,
                width: width * 0.6,
                height: height * 0.6,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
              if (iconVisibility)
                IconButton(
                    onPressed: () {
                      onIconPressed;
                    },
                    icon: Icon(iconData),
                    alignment: Alignment.topRight,
                    iconSize: height * width * 0.1),
              if (iconVisibility)
                Text(date!),
            ],
          ),
        ],
      ),
    );
  }
}
