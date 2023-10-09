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
    isAdded =await FirebaseHelper().addItem(collectionPath: 'tasks', data: taskModel.toJson(),docId: taskModel.id);
    isLoading =false;
    notifyListeners();
  }
}