import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  CustomCheckBox({Key? key, required this.size, required this.borderColor,
  required this.onTap, required this.isSelected}) : super(key: key);
  final double size;
  final Color  borderColor;
  void Function()? onTap;
  final bool isSelected;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: widget.isSelected?Icon( Icons.check_box_rounded,color:Colors.white,size:widget.size,):
      Icon( Icons.square_outlined,color: widget.borderColor,size: widget.size,),);

  }
}
