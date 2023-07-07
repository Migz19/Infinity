import 'package:flutter/cupertino.dart';

class Dot extends StatelessWidget {
  const Dot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.all(Radius.circular(50)),
      ),
      height: 20,
      width: 20,
    );
  }
}