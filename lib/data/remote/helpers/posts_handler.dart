import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/core/utils/app_assets.dart';
import 'package:infinity/data/remote/firebase_helper.dart';
import 'package:infinity/data/remote/helpers/firebase_storage_handler.dart';
import 'package:infinity/models/post/post_model.dart';

class PostHandler {
  Future<void> addNewPost(PostModel model) async {
    model.postId=generateRandomDocId();
    if (model.files != null) {
      model.filesDownloadUrl=await FirebaseStorageHandler.instance().uploadFiles(
          model.files!, AppAssets.stPostPath, model.postId);
    }
    await FirebaseHelper().addPost(model);
  }
}
