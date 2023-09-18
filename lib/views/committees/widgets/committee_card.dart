import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  String imageUri, title;
  bool isNetworkImage;

  CustomCard(
    this.title,
    this.imageUri,
      this.isNetworkImage
  );


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: isNetworkImage ?CachedNetworkImage(
                  imageUrl: imageUri,
                ):Image.asset(imageUri)),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
