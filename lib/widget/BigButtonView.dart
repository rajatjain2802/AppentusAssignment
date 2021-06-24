import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/res/Dimensions.dart';
import 'package:flutter/material.dart';


import 'TextView.dart';

Widget bigButtonView({
  bool isEnabled = true,
  String label = '',
  double labelSize = Dimensions.txtSize18px,
  Color labelColor = AppColor.white,
  Color enableColor = AppColor.btnEnableBg,
  Color disableColor = AppColor.btnDisableBg,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  EdgeInsetsGeometry margin = const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
  EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
  VoidCallback onClick,
  double elevation = 2,
  Color stockColor = AppColor.transparent,
  double minWidth = double.infinity,
  double cornerRadius = 2,
}) {
  return Container(
    margin: margin,
    child: MaterialButton(
      padding: padding,
      child: textView(
          title: label,
          fontSize: labelSize,
          fontColor: labelColor,
          fontWeight: fontWeight,
          fontStyle: fontStyle),
      elevation: elevation,
      minWidth: minWidth,
      onPressed: isEnabled ? onClick : null,
    ),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isEnabled ? enableColor : disableColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        border: Border.all(color: stockColor)),
  );
}
