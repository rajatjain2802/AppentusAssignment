

import 'package:appentus_assignment/res/Strings.dart';

String validateName(String value, String msg) {
  if (value.length < 3)
    return msg ?? Strings.nameValidationMsg;
  else
    return null;
}

String validateMobile(String value, String msg) {
// Indian Mobile number are of 10 digit only
  if (value.length != 10)
    return msg ?? Strings.mobileValidationMsg;
  else
    return null;
}
String validatePassword(String value, String msg) {

  if (value.length <4)
    return msg ?? Strings.mobileValidationMsg;
  else
    return null;
}

String validateEmail(String value, String msg) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return msg ?? Strings.emailValidationMsg;
  else
    return null;
}

String validateValue(String str, String msg) {
  if (str.isEmpty)
    return msg ?? Strings.invalidValue;
  else
    return null;
}
