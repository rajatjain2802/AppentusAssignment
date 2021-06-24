import 'package:appentus_assignment/model/view/IViewModel.dart';
import 'package:flutter/cupertino.dart';

class PhotoViewModel extends IViewModel with ChangeNotifier {
  List<PhotoDataModel> imageList = new List();

  void addList(List<PhotoDataModel> list) {
    imageList.clear();
    imageList.addAll(list);
    notifyListeners();
  }
}

class PhotoDataModel {
  String author;
  String image;
  PhotoDataModel({this.author, this.image});
}
