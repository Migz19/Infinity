import 'dart:io';

import 'package:file_picker/file_picker.dart';

File convertPlatformFileToFile(PlatformFile platformFile) {

  File file = File(platformFile.path!);
  return file;
}
String convertDateToString(DateTime date, bool isDayOnly){

    String year = date.year.toString();

    // Add "0" on the left if month is from 1 to 9
    String month = date.month.toString().padLeft(2, '0');

    // Add "0" on the left if day is from 1 to 9
    String day = date.day.toString().padLeft(2, '0');

    // Add "0" on the left if hour is from 1 to 9
    String hour = date.hour.toString().padLeft(2, '0');

    // Add "0" on the left if minute is from 1 to 9
    String minute = date.minute.toString().padLeft(2, '0');

    // Add "0" on the left if second is from 1 to 9
    String second = date.second.toString();

    // If you only want year, month, and date
    if (isDayOnly == false) {
      return "$year-$month-$day $hour:$minute:$second";
    }

    // return the "yyyy-MM-dd HH:mm:ss" format
    return "$year-$month-$day";
  }



