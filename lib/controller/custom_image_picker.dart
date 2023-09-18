import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CustomImagePicker  {
   Future <File?> pickImage(String imageProvider) async{
     switch(imageProvider){
       case ("gallery"):
        return await _pickImageFromGallery();
       case ("camera"):
          return await _pickImageFromCamera();
     }
     return null;
   }
  Future<File?> _pickImageFromCamera()async {
    final  pickedImageFile =await  ImagePicker().pickImage(source: ImageSource.camera);
    return File (pickedImageFile!.path);
  }

  Future<File?> _pickImageFromGallery() async{
    final pickedImageFile=await  ImagePicker().pickImage(source: ImageSource.gallery);
    return File (pickedImageFile!.path);
  }



}
