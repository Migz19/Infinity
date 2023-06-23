import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinity/src/app_root.dart';

void main() async {
    await SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    runApp(const AppRoot());
}


