import 'package:flutter/material.dart';

enum EmailValidationError {
  empty,
  containSpace,
  invalid,
  withoutCom,
}

extension EmailLastChartExtension on String {
  String lastChars(int n) => substring(length - n);
}

extension EmailErrorExtension on EmailValidationError {
  String emailErrorToText(BuildContext context) {
    switch (this) {
      case EmailValidationError.empty:
        return "required";
      case EmailValidationError.containSpace: //with
        return "contain space";
      case EmailValidationError.invalid:
        return "valid email";
      case EmailValidationError.withoutCom:
        return "without Com";
    }
  }
}

class EmailValidation {
  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9.]+@[a-zA-Z]+.{1}[a-zA-Z]+(.{0,1}[a-zA-Z]+)$');

  static EmailValidationError? validator(String value) {
    return value.isEmpty
        ? EmailValidationError.empty
        : value.toString().contains(" ")
            ? EmailValidationError.containSpace
            : (int.tryParse(value.split('@')[0]) is int ||
                    !_emailRegExp.hasMatch(value))
                ? EmailValidationError.invalid
                : value.lastChars(3) != "com"
                    ? EmailValidationError.withoutCom
                    : null;
  }
}
