import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/task/task_model.dart';
import 'package:infinity/models/user/user_model.dart';
import 'package:infinity/views/committees/model/committee_model.dart';

class CommitteeDetailsProvider extends ChangeNotifier {
  List<CommitteeModel> committeesList = [];

  Future<List<CommitteeModel>> getCommitteesList() async {
    if (committeesList.isEmpty) {
      await FirebaseHelper().getAllItems('committees').then((snapshotDocs) {
        if (snapshotDocs.isNotEmpty) {
          for (var singleSnapshot in snapshotDocs) {
            CommitteeModel model =
                CommitteeModel.fromJson(json: singleSnapshot.data());
            committeesList.add(model);
          }
        }
      });
    }
    notifyListeners();
    return committeesList;
  }

  Future<List<UserModel>> getMembersList(CommitteeModel committee) async {
    List<UserModel> committeeMembers = [];
    if (committeesList.isNotEmpty) {
      for (var id in committeesList
          .elementAt(committeesList.indexOf(committee))
          .membersIds) {
        UserModel? model;
        try {
          await FirebaseHelper()
              .getUserData(UId: id, collectionName: 'users')
              .then((value) => model = UserModel.fromJson(json: value));
        } catch (error) {
          await FirebaseHelper()
              .getUserData(UId: id, collectionName: 'admin')
              .then((value) {
            model = UserModel.fromJson(json: value);
          });
        }
        committeeMembers.add(model!);
      }
    }
    return committeeMembers;
  }

  Future<List<TaskModel>> getCommitteeTasks(CommitteeModel committee) async {
    List<TaskModel> committeeTasks = [];
    if (committeesList.isNotEmpty) {
      for (var id in committeesList
          .elementAt(committeesList.indexOf(committee))
          .tasksIds) {
        print("239042038432    -> "+id);
        TaskModel? taskModel;
        try {
          await FirebaseHelper()
              .getItem('tasks', id)
              .then((value) {
            print("239042038432    ->"+value.toString());
                taskModel = TaskModel.fromJson(json: value);});

        } catch (error) {
          print(error);
        }
        committeeTasks.add(taskModel!);
      }
    }
    print('239042038432    ->${committeeTasks.length}');
    return committeeTasks;
  }
}
