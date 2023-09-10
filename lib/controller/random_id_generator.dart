 import 'dart:math';

String generateRandomDocId(){
   const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
   Random rnd = Random();

   return  String.fromCharCodes(Iterable.generate(
       28, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
 }