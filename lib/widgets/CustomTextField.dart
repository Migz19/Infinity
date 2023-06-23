import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';

class CustomTextField extends StatefulWidget {
var prefixIcon;
 Icon? suffixIcon=null;
 late String label;


CustomTextField(this.prefixIcon, this.suffixIcon, this.label);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      //validator: ,
      decoration: InputDecoration(
        focusColor: AppColor.primary,
        prefixIcon:  Icon(widget.prefixIcon,size: 10,color: AppColor.primary,),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
