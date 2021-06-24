import 'dart:io';

import 'package:appentus_assignment/res/AppColor.dart';
import 'package:flutter/material.dart';

import 'ImageViewAssets.dart';

AppBar toolBar({
  @required String toolBarTitle,
  Color toolBarTitleColor = AppColor.white,
  @required VoidCallback onClick,
  IconData toolBarIcon = Icons.arrow_back,
  Color toolBarIconColor = AppColor.white,
  Color toolBarBgColor = AppColor.primaryDark,
  double elevation = 5,
  bool isImageTitle = false,
  File imagePath,
  double imageWidth = 0.0,
  double imageHeight = 0.0,
  BoxFit fit = BoxFit.none,
  List<Widget> actions,
}) {
  return AppBar(
    titleSpacing: 0,
    title: isImageTitle
        ? Row(
          children: [
            Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all(), color: Colors.white70),
                width: 50,
                height: 50,
                child: ClipOval(
                  child: imagePath != null
                      ? imageViewFile(
                          imagePath: imagePath, imageWidth: 50, imageHeight: 50, fit: BoxFit.contain)
                      : imageViewAsset(
                          imagePath: 'assets/images/profile_dummy.jpg',
                          imageHeight: 90,
                          imageWidth: 90,
                          fit: BoxFit.contain),
                ),
              ),
            Text(
              toolBarTitle,
              style: TextStyle(
                color: toolBarTitleColor,
              ),
            ),
          ],
        )
        : Text(
            toolBarTitle,
            style: TextStyle(
              color: toolBarTitleColor,
            ),
          ),
    iconTheme: IconThemeData(color: AppColor.toolbarIconColorDark),
    leading: IconButton(
        icon: Icon(
          toolBarIcon,
          color: toolBarIconColor,
        ),
        onPressed: onClick),
    elevation: elevation,
    backgroundColor: toolBarBgColor,
    actions: actions,
  );
}

AppBar toolBarWithSubTitle({
  @required String toolBarTitle,
  String subTitle,
  Color toolBarTitleColor = AppColor.white,
  Color toolBarSubTitleColor = AppColor.white,
  @required VoidCallback onClick,
  IconData toolBarIcon = Icons.arrow_back,
  Color toolBarIconColor = AppColor.white,
  Color toolBarBgColor = AppColor.red,
  double elevation = 5,
  double subTitleSize = 12,
  double titleSize = 16,
  bool isImageTitle = false,
  String imagePath = '',
  double imageWidth = 0.0,
  double imageHeight = 0.0,
  BoxFit fit = BoxFit.none,
  EdgeInsetsGeometry margin = const EdgeInsets.all(0),
  List<Widget> actions,
}) {
  return AppBar(
    titleSpacing: 0,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          toolBarTitle,
          style: TextStyle(
            color: toolBarTitleColor,
            fontSize: titleSize,
          ),
        ),
        Container(
          margin: margin,
          child: Text(
            subTitle,
            style: TextStyle(
              color: toolBarSubTitleColor,
              fontSize: subTitleSize,
            ),
          ),
        ),
      ],
    ),
    iconTheme: IconThemeData(color: AppColor.toolbarIconColorDark),
    leading: IconButton(
        icon: Icon(
          toolBarIcon,
          color: toolBarIconColor,
        ),
        onPressed: onClick),
    elevation: elevation,
    backgroundColor: toolBarBgColor,
    actions: actions,
  );
}

AppBar toolBarWithoutIcon(
    {@required String toolBarTitle,
    Color toolBarTitleColor = AppColor.white,
    IconData toolBarIcon = Icons.arrow_back,
    Color toolBarIconColor = AppColor.white,
    Color toolBarBgColor = AppColor.primaryDark,
    double elevation = 5,
    bool isImageTitle = false,
    String imagePath = '',
    double imageWidth = 0.0,
    double imageHeight = 0.0,
    BoxFit fit = BoxFit.none,
    List<Widget> actions}) {
  return AppBar(
    title: isImageTitle
        ? Image.asset(
            imagePath,
            width: imageWidth,
            height: imageHeight,
            fit: fit,
          )
        : Text(
            toolBarTitle,
            style: TextStyle(
              color: toolBarTitleColor,
            ),
          ),
    iconTheme: IconThemeData(color: AppColor.toolbarIconColorDark),
    elevation: elevation,
    automaticallyImplyLeading: false,
    backgroundColor: toolBarBgColor,
    actions: actions,
  );
}
