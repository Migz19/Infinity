import 'package:flutter/material.dart';

import '../../core/utils/hex_color.dart';
import 'enum.dart';

class ToastConfig {
  static void showToast({
    required BuildContext context,
    required String msg,
    required ToastStates toastStates,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              16.0,
            ),
          ),
        ),
        content: ListTile(
          horizontalTitleGap: 8.0,
          title: Text(
            chooseToastTitle(state: toastStates,context: context),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
          leading: Icon(
            chooseToastIcon(toastStates),
            color: Colors.white,
            size: 32.0,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: chooseToastColor(toastStates),
      ),
    );
  }
}

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.Success:
      color = HexColor('#6F995B');
      break;
    case ToastStates.Error:
      color = HexColor('#F93535');
      break;
    case ToastStates.Warning:
      color = HexColor('#E5B61B');
      break;
    case ToastStates.Warning:
      color = HexColor('#E5B61B');
      break;
  }
  return color;
}

IconData chooseToastIcon(ToastStates state) {
  late IconData icon;
  switch (state) {
    case ToastStates.Success:
      icon = Icons.check_circle_outline_rounded;
      break;
    case ToastStates.Error:
      icon = Icons.error_outline;
      break;
    case ToastStates.Warning:
      icon = Icons.warning_amber_rounded;
      break;
  }
  return icon;
}

String chooseToastTitle(
    {required ToastStates state, required BuildContext context}) {
  late String title;
  switch (state) {
    case ToastStates.Success:
      title = "Success";
      break;
    case ToastStates.Error:
      title = "Error";
      break;
    case ToastStates.Warning:
      title = "Warning";
      break;
  }
  return title;
}
