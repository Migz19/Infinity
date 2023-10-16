import 'package:flutter/material.dart';
import 'package:infinity/core/utils/media_query.dart';

import '../core/utils/app_color.dart';

class CustomTypeButton extends StatelessWidget {
  CustomTypeButton({Key? key, this.onTap, required this.text,this.radius,
  this.buttonColor,this.textColor=Colors.white,this.width, this.isLoading}) : super(key: key);
  final void Function()? onTap;
  final String text;
  Color ?buttonColor;
  Color ?textColor;
  double ?width;
  bool  ? isLoading=false;
  double ?radius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width:width ?? context.width,
        height: context.height*0.06,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
           //border: Border.all(0),
          border: Border.all(color: Colors.white,width: 2),
          borderRadius: BorderRadius.circular(radius??5),
          color:buttonColor==null?AppColor.primary:
          buttonColor,
        ),
        child:
        isLoading==true?CircularProgressIndicator(
          color:Colors.white,
        ):
        Text(textAlign: TextAlign.center,
          text,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
        color: textColor),),
      ),
    );
  }
}
