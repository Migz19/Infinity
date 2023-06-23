import 'package:flutter/cupertino.dart';

/// Validation errors for the [Username] [FormzInput].
enum UsernameValidationError {
  /// Generic invalid error.
  empty,
  smallLength,
  largeLength,
  containSpaces,
  invalid,
}

extension UsernameErrorExtension on UsernameValidationError {
  String usernameErrorToText(BuildContext context) {
    switch (this) {
      case UsernameValidationError.empty:
        return "required";
      case UsernameValidationError.smallLength: //with
        return "small length";
      case UsernameValidationError.largeLength: //with
        return "large length";
      case UsernameValidationError.containSpaces: //with
        return "contain space";
      case UsernameValidationError.invalid:
        return "invalid username";
    }
  }
}

/// Form input for an password input.
class UsernameValidation {
  static UsernameValidationError? validator({
    required String value,
  }) {
    if (value.isEmpty) {
      return UsernameValidationError.empty;
    } else if (value.toString().length < 5) {
      return UsernameValidationError.smallLength;
    } else if (value.toString().length > 50) {
      return UsernameValidationError.largeLength;
    } else if (value.toString().contains(" ")) {
      return UsernameValidationError.containSpaces;
    } else if (!RegExp(r'^[a-z A-Z0-9._\-=@,$.;%#!^&*]+$').hasMatch(value) &&
        !RegExp(r"^[\u0621-\u064A ]+$").hasMatch(value)) {
      return UsernameValidationError.invalid;
    } else {
      return null;
    }
  }
}
