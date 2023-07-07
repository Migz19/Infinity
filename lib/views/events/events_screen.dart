import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/event/event_model.dart';

import 'widgets/event_list.dart';

class EventScreen extends StatelessWidget {
 const EventScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text(
          "Events",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500,color: AppColor.tertiary),
        ),
        toolbarHeight: 0.0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        width: context.width,height: context.height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ServiceList(eventList: [
          EventModel(title: "Event Cairo",
              images:[
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://brisbanekids.com.au/wp-content/uploads/2022/05/Lifeline-Bookfest-Books.jpg',
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ85kkd4AtEaVGkngwGjz2UjlfaqLsvLffRCzFDotXhzVX46SF5L8fJ1KIINB3B5QknJQE&usqp=CAU',
              ], date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else.But keeping them happy enough to come back is something else."*20),
          EventModel(title: "Event Cairo",
            images:[
              'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
              'https://brisbanekids.com.au/wp-content/uploads/2022/05/Lifeline-Bookfest-Books.jpg',
              'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ85kkd4AtEaVGkngwGjz2UjlfaqLsvLffRCzFDotXhzVX46SF5L8fJ1KIINB3B5QknJQE&usqp=CAU',
            ], date: DateTime.now().toString(),
            location: "Cairo,Naser City",
            description: "But keeping them happy enough to come back is something else."*10),
          EventModel(title: "Event Cairo",
              images:[
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://brisbanekids.com.au/wp-content/uploads/2022/05/Lifeline-Bookfest-Books.jpg',
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ85kkd4AtEaVGkngwGjz2UjlfaqLsvLffRCzFDotXhzVX46SF5L8fJ1KIINB3B5QknJQE&usqp=CAU',
              ], date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),

          EventModel(title: "Event Cairo",
              images:[
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://brisbanekids.com.au/wp-content/uploads/2022/05/Lifeline-Bookfest-Books.jpg',
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ85kkd4AtEaVGkngwGjz2UjlfaqLsvLffRCzFDotXhzVX46SF5L8fJ1KIINB3B5QknJQE&usqp=CAU',
              ], date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),
          EventModel(title: "Event Cairo",
              images:[
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://brisbanekids.com.au/wp-content/uploads/2022/05/Lifeline-Bookfest-Books.jpg',
                'https://www.masseycollege.ca/wp-content/uploads/2023/06/Book-Club-April-2023.-Group-photo.jpg',
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ85kkd4AtEaVGkngwGjz2UjlfaqLsvLffRCzFDotXhzVX46SF5L8fJ1KIINB3B5QknJQE&usqp=CAU',
              ], date: DateTime.now().toString(),
              location: "Cairo,Naser City",
              description: "But keeping them happy enough to come back is something else."*10),

        ]),
      ),

    );
  }


}
