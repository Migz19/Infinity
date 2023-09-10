import 'dart:io';

import 'package:file_picker/file_picker.dart';

File platformFileToFile(PlatformFile platformFile) {

  File file = File(platformFile.path!);
  return file;
}
