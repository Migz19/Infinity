import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';

class CustomDropDownButton extends StatefulWidget {
  late List<String> list;
  String?  currentIndex;
  double width = 20, height = 1;
   Function(String) onItemSelected;

  CustomDropDownButton(this.list,
      {super.key,
      required this.onItemSelected,
      required this.width,
      required this.height}){
    currentIndex=list.first;
  }

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          border: Border.all(style: BorderStyle.solid, color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: DropdownButton<String>(

        focusColor: AppColor.second,
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style:  TextStyle(color: AppColor.primary, fontSize: widget.height*0.4)),
          );
        }).toList(),
        elevation: 5,
        isExpanded: true,
        value: widget.currentIndex,
        underline: const SizedBox(),
        onChanged: (String? value) {
          setState(() {
            widget.currentIndex = value!;
            widget.onItemSelected(value);
          });
        },
        iconDisabledColor: Colors.grey.shade100,
        iconEnabledColor: AppColor.primary,
        icon: Icon(
          Icons.arrow_drop_down,
          color:AppColor.primary,
        ),
      ),
    );
  }
}
