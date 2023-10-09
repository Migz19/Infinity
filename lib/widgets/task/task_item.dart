import 'package:flutter/material.dart';
import 'package:infinity/models/task/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(task.title),
          SizedBox(height: 10,),
          Text(task.description),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
