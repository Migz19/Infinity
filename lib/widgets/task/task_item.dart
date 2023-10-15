import 'package:flutter/material.dart';
import 'package:infinity/core/utils/app_color.dart';
import 'package:infinity/core/utils/media_query.dart';
import 'package:infinity/models/task/task_model.dart';

import '../../controller/converters.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColor.primary.withOpacity(0.7),
      ),
      height: context.height * 0.25,
      width: context.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 15, right: 10, left: 20),
                child: Text(
                  task.title,
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                    color: AppColor.second
                        .withOpacity(0.4)),
                alignment: Alignment.center,
                width: 60,
                height: 50,
                child: Text(
                  getDateInSpecialFormat(task.deadLine),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Actor',
                    fontWeight: FontWeight.w400,

                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 15, right: 10, left: 20),
            child: Text(
              task.description,
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
            ),
          ),
          task.isFinished? Padding(
            padding: const EdgeInsets.only(left:140,top: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Text(
                    "   Finished",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: Colors.black,
                    size: 17,
                  )
                ],
              ),
            ),
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                  Text(
                      "   Running",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.running_with_errors,
                      color: Colors.black,
                      size: 17,
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: TextButton(
                    child: Text(
                      "Finish",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
