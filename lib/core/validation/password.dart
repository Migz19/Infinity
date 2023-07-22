import 'package:flutter/cupertino.dart';

enum PasswordValidationError {
  empty,
  smallLength,
  containSpaces,
  // containNumber,
  // containSpecialCharacters,
}

extension PasswordErrorExtension on PasswordValidationError {
  String passwordErrorToText({required BuildContext context}) {
    switch (this) {
      case PasswordValidationError.empty:
        return "required";
      case PasswordValidationError.smallLength:
        return "invalid password";
      case PasswordValidationError.containSpaces:
        return "Password_Must_Not_Be_Include_Space";

    }
  }
}

/// Form input for an password input.
class PasswordValidation {
  static PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.toString().length < 6) {
      return PasswordValidationError.smallLength;
    } else if (value.toString().contains(" ")) {
      return PasswordValidationError.containSpaces;
    } else {
      return null;
    }
    // else if (!RegExp(r'[0-9]').hasMatch(value)) {
    //   return PasswordValidationError.containNumber;
    // }
    // else if (!RegExp(r'^(?=.{3,})(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=]).*')
    //     .hasMatch(value)) {
    //   return PasswordValidationError.containSpecialCharacters;
    // }
  }
}
