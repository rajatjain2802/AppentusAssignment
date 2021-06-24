// To parse this JSON data, do
//
//     final photoDto = photoDtoFromJson(jsonString);

import 'dart:convert';

import 'package:appentus_assignment/util/Utils.dart';

List<PhotoModel> photoDtoFromJson(String str) =>
    str != null ? List<PhotoModel>.from(json.decode(str).map((x) => PhotoModel.fromJson(x))) : [];

String photoDtoToJson(List<PhotoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhotoModel {
  PhotoModel({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.downloadUrl,
  });

  String id;
  String author;
  int width;
  int height;
  String url;
  String downloadUrl;

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
        id: getFieldValue(json, "id"),
        author: getFieldValue(json, "author"),
        width: getFieldValueInteger(json, "width"),
        height: getFieldValueInteger(json, "height"),
        url: getFieldValue(json, "url"),
        downloadUrl: getFieldValue(json, "download_url"),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
      };
}
