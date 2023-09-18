import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/models/committee/committee_model.dart';

class CommitteeDetailsProvider extends ChangeNotifier {
  List<CommitteeModel> committeesList = [];

  Future<void> getCommitteesList() async {
    await FirebaseHelper()
        .getAllItems('committees')
        .then((value) => committeesList);
  }
}
