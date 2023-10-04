import 'package:flutter/material.dart';

import '../../models/task/task_model.dart';

class TasksScreen extends StatefulWidget {

   List<TaskModel>tasksList;


  TasksScreen(this.tasksList);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ListView.separated(
      //     itemBuilder:,
      //     separatorBuilder: separatorBuilder,
      //     itemCount: itemCount),
    );
  }
}
