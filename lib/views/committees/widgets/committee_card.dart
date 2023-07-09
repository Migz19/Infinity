import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {

  String imageUri,title;


  CustomCard(this.title,this.imageUri, );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: CircleAvatar(child: Image.asset(imageUri,),radius: 20,backgroundColor: Colors.transparent),
          ),
          Text(title,style: TextStyle(color: Colors.black,fontSize: 15),),
        ],
      ),
    );
  }
}
