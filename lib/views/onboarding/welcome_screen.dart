import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/widgets/bottomsheet/welcome_bottom_sheet.dart';

import '../../core/utils/app_assets.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.backgroundLogo,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
            Column(
              children: [
                Hero(
                    child: Image.asset(
                      AppAssets.logo,
                      height: 200,
                      width: 200,
                    ),
                    tag: 'logo'),
                const SizedBox(
                  height: 8,
                ),
                // const Text("Infinity Club is 37485478743587348yfdsjhfjsdhufhiush8ry4289ry8owhdufhiwhfuhwuiehfiuhweiufhiu234hiufhweiuhefiuhweiuhfiuwehefuhwuehfuwhewiufhweiuhf"),
              ],
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: WelcomeBottomSheet(),
            ),
          ],
        ),
      ),
    );
  }
}
