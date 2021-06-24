import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/res/Dimensions.dart';
import 'package:appentus_assignment/res/Strings.dart';
import 'package:appentus_assignment/util/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'ImageViewAssets.dart';
import 'TextView.dart';

Future<PickedFile> pickImageFromDeviceBottomSheet(BuildContext context) async {
  Future<PickedFile> s = showModalBottomSheet<PickedFile>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            textView(
                fontColor: AppColor.txtColorBlack,
                title: "Add File",
                fontSize: Dimensions.txtSize15px,
                margin: EdgeInsets.only(left: 20, top: 28, bottom: 10)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: textView(
                  title: Strings.take_photo,
                  fontColor: AppColor.txtColorBlack,
                  fontSize: Dimensions.txtSize15px),
              leading: imageViewAsset(
                  imagePath: 'assets/images/camera1.png',
                  fit: BoxFit.contain,
                  imageWidth: 30,imageHeight: 30,
                  margin: EdgeInsets.only(left: 20, top: 3)),
              onTap: () async {
                chooseFile(imageSource: ImageSource.camera).then((value) {
                  Navigator.of(context).pop(value);
                });
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: textView(
                  title: Strings.choose_from_gallery,
                  fontColor: AppColor.txtColorBlack,
                  fontSize: Dimensions.txtSize15px),
              leading: imageViewAsset(
                  imagePath: 'assets/images/gallery1.png',
                  imageWidth: 30,imageHeight: 30,
                  fit: BoxFit.contain,
                  margin: EdgeInsets.only(left: 20, top: 3)),
              onTap: () async {
                chooseFile(imageSource: ImageSource.gallery).then((value) {
                  Navigator.of(context).pop(value);
                });
              },
            ),
            Container(
              margin: EdgeInsets.all(10),
            )
          ],
        );
      });
  return s;
}
