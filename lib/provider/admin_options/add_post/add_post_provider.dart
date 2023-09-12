import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:infinity/controller/converters.dart';
import 'package:infinity/controller/random_id_generator.dart';
import 'package:infinity/data/remote/helpers/posts_handler.dart';
import 'package:infinity/models/post/post_model.dart';

import '../../../controller/custom_file_picker.dart';

class AddPostProvider extends ChangeNotifier{
bool addPostState=false;
bool addFilesState=false;
  Future<void> addNewPost (PostModel postModel)async{
    notifyListeners();
    addPostState=true;
    await PostHandler().addNewPost(postModel);
    print("post added${postModel.files?.first.path}");
    addPostState=false;
    notifyListeners();
  }
Future<List<File>?> pickFiles ()async{
  notifyListeners();
   addFilesState=true;
  List<File>?imageFiles=await CustomFilePicker().pickMultipleImages();
   addFilesState=false;
  notifyListeners();
  return imageFiles;
}
}