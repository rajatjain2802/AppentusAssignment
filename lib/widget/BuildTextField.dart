import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/util/constants.dart';
import 'package:flutter/material.dart';

import 'EditTextBorder.dart';
import 'TextView.dart';

Widget buildTF(
    {@required String label,
      @required String hint,
      @required TextEditingController controller,
      @required FocusNode focusNode,
      @required IconData icon,
      int maxLength = 50,
      @required String Function(String) validationFunc,
      TextInputType inputType = TextInputType.text}) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        textView(title: label, fontColor: Colors.white, fontWeight: FontWeight.bold),
        SizedBox(height: 10.0),
        editTextBorder(
          hint: hint,
          decoration: kBoxDecorationStyle,
          mode: AutovalidateMode.disabled,
          txtColor: AppColor.white,
          controller: controller,
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          focus: focusNode,
          inputType: inputType,
          maxlength: maxLength,
          validator: (value) {
            return validationFunc(value);
          },
        )
      ],
    ),
  );
}
