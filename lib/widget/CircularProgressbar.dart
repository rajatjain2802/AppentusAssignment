import 'package:flutter/material.dart';

Widget circularProgress({Color progressColor = Colors.white}) {
  return Center(
    child: Container(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(progressColor),
      ),
    ),
  );
}
