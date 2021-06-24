import 'package:appentus_assignment/widget/CircularProgressbar.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'ImageViewAssets.dart';

Widget networkImageView(
    {EdgeInsetsGeometry margin = const EdgeInsets.all(0),
    EdgeInsetsGeometry padding = const EdgeInsets.all(0),
    String placeHolder = '',
    String imagePath = '',
    double height,
    double width,
    BoxFit boxFit = BoxFit.fill}) {
  return Container(
    height: height,
    width: width,
    margin: margin,
    child: Padding(
      padding: padding,
      child: ExtendedImage.network(
        imagePath,
        fit: boxFit,
        cache: true,
        enableLoadState: true,
        loadStateChanged: (ExtendedImageState state) {
          Widget widget;
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              widget = circularProgress(progressColor: Colors.blue);
              break;
            case LoadState.completed:
              break;
            case LoadState.failed:
              state.reLoadImage();
              widget = imageViewAsset(
                  imagePath: "assets/images/no_image_available_icon.png",
                  imageWidth: width,
                  imageHeight: height,
                  fit: boxFit,
                  margin: margin,
                  padding: padding);
              break;
          }
          return widget;
        },
        retries: 3,
      ),
    ),
  );
}
