
import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/res/Dimensions.dart';
import 'package:flutter/material.dart';

Widget textView({
  EdgeInsetsGeometry margin = const EdgeInsets.all(0),
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  String title = '',
  double fontSize = Dimensions.txtSize13px,
  Color fontColor = AppColor.txtColorGray,
  FontStyle fontStyle = FontStyle.normal,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.left,
  Color containerBg = AppColor.transparent,
  double width,
  TextDecoration textDecoration = TextDecoration.none,
  Alignment alignment,
  int maxLine = 1,
  TextOverflow overflow = TextOverflow.visible,
}) {
  return title != null && title.isNotEmpty
      ? Container(
          margin: margin,
          width: width,
          color: containerBg,
          alignment: alignment,
          child: Padding(
              padding: padding,
              child: Text(
                title,
                overflow: overflow,
                maxLines: maxLine,
                style: TextStyle(
                  decoration: textDecoration,
                  fontSize: fontSize,
                  color: fontColor,
                  fontStyle: fontStyle,
                  fontFamily: 'OpenSans',
                  fontWeight: fontWeight,
                ),
                textAlign: textAlign,
              )),
        )
      : Container();
}
