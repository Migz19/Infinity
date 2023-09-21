import 'package:flutter/cupertino.dart';
import 'package:infinity/data/remote/firebase_helper.dart';

import '../../models/event/event_model.dart';
import '../../models/post/post_model.dart';

class HomeProvider extends ChangeNotifier {
  bool eventsLoaded = false;
  bool postsLoaded = false;
  List<EventModel> upcomingEvents = [];
  List<PostModel> postsList =[];
  Future<void> getAllPosts()async{
    if(postsList.isEmpty) {
      var eventsSnapshotDocs = await FirebaseHelper().getAllItems("posts");
      if (eventsSnapshotDocs.isNotEmpty) {
        for (var eventSnapshot in eventsSnapshotDocs) {
          PostModel model = PostModel.fromJson(json: eventSnapshot.data());
          postsList.add(model);
        }
      }
    }
    notifyListeners();
}
}
