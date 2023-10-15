import 'package:flutter/material.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/task/task_model.dart';

class AddTaskProvider extends ChangeNotifier{
  TaskModel? taskModel;
  bool isAdded=false;
  bool isLoading=false;
  Future<void>addTask(TaskModel taskModel)async{
    isLoading=true;
    notifyListeners();
    if (DateTime.parse(taskModel.deadLine).isBefore(DateTime.now())) {
      taskModel.isFinished=true;
    }
    isAdded =await FirebaseHelper().addTask(collectionPath: 'tasks',committee:taskModel.committeeName, data: taskModel.toJson(),docId: taskModel.id);
    isLoading =false;
    notifyListeners();
  }
}