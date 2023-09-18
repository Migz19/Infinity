import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/views/committees/model/committee_model.dart';


class CommitteeDetailsProvider extends ChangeNotifier {
  List<CommitteeModel> committeesList = [];

  Future<void> getCommitteesList() async {
if(committeesList.isEmpty) {
  await FirebaseHelper()
        .getAllItems('committees').then((snapshotDocs) {
    if (snapshotDocs.isNotEmpty) {
      for (var singleSnapshot in snapshotDocs) {
        CommitteeModel model = CommitteeModel.fromJson(json: singleSnapshot.data());
        committeesList.add(model);
      }
    }
    });
}
    notifyListeners();
  }
}
