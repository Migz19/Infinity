import 'dart:io';


class PostModel{
 String postDetails;
 List<File>? files;
 String _postId='';
 List<String> _filesDownloadUrl=[];


 List<String> get filesDownloadUrl => _filesDownloadUrl;

  set filesDownloadUrl(List<String> value) {
    _filesDownloadUrl = value;
  }

  PostModel({required this.postDetails,files});

 String get postId => _postId;

  set postId(String value) {
    _postId = value;
  }
}