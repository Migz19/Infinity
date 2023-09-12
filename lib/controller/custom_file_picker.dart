import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'converters.dart';

class CustomFilePicker {
  bool isLoading = false;

  Future<List<File>?> pickMultipleImages() async {
    var result = await FilePicker.platform.pickFiles(
      allowMultiple: true, onFileLoading: (p0) => isLoading,type: FileType.image);
    {
      if (result!=null){
        List<File>files= result.files.map(convertPlatformFileToFile).toList();

        return files;
      }
      return null;
    }
  }
  Future <List<File>?> pickMultipleFiles()async{
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: true, onFileLoading: (p0) => isLoading,type: FileType.any);
    {
      if (result!=null){
        List<File>files= result.files.map(convertPlatformFileToFile).toList();
        print("99999 files not empty");
        return files;
      }
      return null;
    }
  }
}