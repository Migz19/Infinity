import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  double width, height;
  String imageUri;
  String title;
  String? date;
  Function? onPressed;
  Function? onIconPressed;
  bool iconVisibility;
  IconData? iconData;

  CustomCard(
      {required this.width,
      required this.height,
      required this.imageUri,
      required this.title,
      required this.iconVisibility,
      this.onIconPressed,
  this.onPressed,
      this.iconData,
      this.date});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed!(),
      child: Container(
        width: width * 0.7,
        height: height * 0.7,
        color: Colors.blue,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              fit: StackFit.loose,
              children: [
                Image.asset(
                  imageUri,
                  width: width * 0.6,
                  height: height * 0.6,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
                if (iconVisibility)
                  Container(
                    width: 20,
                    height: 20,
                    child: IconButton(
                        onPressed: () {
                          onIconPressed;
                        },
                        icon: Icon(iconData),
                        alignment: Alignment.topRight,
                        disabledColor: Colors.grey,
                        color: Colors.white,
                        iconSize: 30),
                  ),
                if (iconVisibility)
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(5)),
                    child: Card(
                      child: Text(date!,
                          style: TextStyle(fontSize: 20, color: Colors.pink)),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
