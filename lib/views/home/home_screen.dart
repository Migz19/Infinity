import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/widgets/home/custom_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        width: context.width * 0.5,
        height: context.width * 0.5,
        imageUri: AppAssets.backgroundLogo,
        title: "AHSJHDSJ",
        iconVisibility: true);
  }
}
