import 'package:flutter/material.dart';

enum ConfirmedPasswordValidationError { invalid }

extension PasswordErrorExtension on ConfirmedPasswordValidationError {
  String passwordErrorToText({required BuildContext context}) {
    switch (this) {
      case ConfirmedPasswordValidationError.invalid:
        return "match password";
    }
  }
}

class ConfirmedPassword {
  ConfirmedPassword({required this.password});

  final String password;

  ConfirmedPasswordValidationError? validator(String? value) {
    return password == value &&password.isNotEmpty? null : ConfirmedPasswordValidationError.invalid;
  }
}
