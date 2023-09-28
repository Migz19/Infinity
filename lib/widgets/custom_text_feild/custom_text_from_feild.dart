import 'package:flutter/material.dart';




class CustomTextFromField extends StatefulWidget {
  CustomTextFromField({required this.textEditingController,
    required this.hint, required this.label, this.validator,
    this.textInputType,this.maxLength,this.prefixIcon,this.suffixIcon,
    this.backgroundColor,
    this.obscureText,
    this.ontap,
    this.validateText,
    this.hintColor,
  this.enabled});
  final TextEditingController textEditingController;
  final String hint;
  final String label;
  Color ?backgroundColor;
  String? Function(String?)?validator;
  Widget? prefixIcon;
  Color ?hintColor;
  TextInputType?textInputType=TextInputType.none;
  Widget? suffixIcon;
  int? maxLength;
  bool?obscureText;
  VoidCallback? ontap;
  String? validateText;
  bool ? enabled;
  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {

  //Color ?colorBackground=Colors.grey.shade600;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 16),
      alignment: Alignment.center,
      child: TextFormField(
        onTap: widget.ontap,
        validator: widget.validator , obscureText: widget.obscureText??false,
        keyboardType: widget.textInputType,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            height: 0,
            color: Colors.transparent,
          ),
          fillColor: widget.backgroundColor==null?Colors.grey.shade600:widget.backgroundColor,
          border: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.grey) ,
            borderRadius: BorderRadius.circular(10,),
          ),
          filled: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon==null?SizedBox():widget.suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderSide:BorderSide(color: Colors.grey) ,
            borderRadius: BorderRadius.circular(10,),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,
              color:widget.hintColor==null?Colors.white:widget.hintColor),
        ),
      ),
    );
  }
}
