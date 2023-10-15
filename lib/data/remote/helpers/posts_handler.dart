import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/data/remote/helpers/firebase_storage_handler.dart';
import 'package:infinity/models/post/post_model.dart';

import '../../../core/utils/app_constants.dart';

class PostHandler {
  Future<void> addNewPost(PostModel model) async {
    model.postId=generateRandomDocId();
    if (model.files != null) {
      model.filesDownloadUrl=await FirebaseStorageHandler.instance().uploadFiles(
          model.files!, AppConstants.stPostPath, model.postId);
    }
    await FirebaseHelper().addPost(model);
  }
}
