import 'package:flutter/material.dart';

class FormUtility {
  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String emailPatternValidation(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid Email Address';
    else
      return null;
  }

  String passwordPatternValidation(String value) {
    Pattern pattern = r'(?=.*[A-Z])(?=.*[0-9])\S{6,}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password should have minimum 6 characters, at least 1 uppercase letter and 1 number';
    else
      return null;
  }
  String confirmPasswordValidation(String value, String pwd) {
    if (value != pwd)
      return 'Your password and confirmation password do not match.';
    return null;
  }
}
