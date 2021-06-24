import 'dart:io';

import 'package:flutter/material.dart';

Widget imageViewAsset({
  EdgeInsetsGeometry margin = const EdgeInsets.all(0),
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  @required String imagePath,
  double imageWidth,
  double imageHeight,
  BoxFit fit = BoxFit.none,
  Alignment alignment,
}) {
  return Container(
    margin: margin,
    alignment: alignment,
    padding: padding,
    child: Image.asset(
      imagePath,
      width: imageWidth ?? null,
      height: imageHeight ?? null,
      fit: fit,
    ),
  );
}



Widget imageViewFile({
  EdgeInsetsGeometry margin = const EdgeInsets.all(0),
  EdgeInsetsGeometry padding = const EdgeInsets.all(0),
  @required File imagePath,
  double imageWidth,
  double imageHeight,
  BoxFit fit = BoxFit.none,
  Alignment alignment,
}) {
  return Container(
    margin: margin,
    alignment: alignment,
    padding: padding,
    child: Image.file(
      imagePath,
      width: imageWidth ?? null,
      height: imageHeight ?? null,
      fit: fit,
    ),
  );
}
