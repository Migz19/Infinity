import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  static late Function onItemPressed;
  List<dynamic> itemsList;
  int crossAxisCount;
  double mainAxisSpacing ;
  dynamic child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        mainAxisSpacing: mainAxisSpacing,
        children: itemsList
            .map(
              (data) => GestureDetector(
                child: child,
                onTap: getCurrentIndex(data),
              ),

            )
            .toList(),
      ),
    );
  }

  CustomGridView({required this.itemsList,required this.crossAxisCount,
      required this.child,  this.mainAxisSpacing=0,
      super.key, required onItemPressed});
  static getCurrentIndex(dynamic data){
   onItemPressed();
    return data;
  }
  void setOnItemPressed(Function pressed){
    onItemPressed=pressed;
  }
}
