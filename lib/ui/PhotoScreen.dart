import 'dart:io';

import 'package:appentus_assignment/base/BaseResponseListener.dart';
import 'package:appentus_assignment/base/ScreenState.dart';
import 'package:appentus_assignment/data/local/UserModel.dart';
import 'package:appentus_assignment/data/network/api/BaseApi.dart';
import 'package:appentus_assignment/model/view/PhotoViewModel.dart';
import 'package:appentus_assignment/repository/Repository.dart';
import 'package:appentus_assignment/widget/NetworkImageView.dart';
import 'package:appentus_assignment/widget/TextView.dart';
import 'package:appentus_assignment/widget/Toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PhotoScreen extends ScreenState {
  @override
  Widget getBuildWidget(BuildContext context) {
    return Consumer<PhotoViewModel>(
      builder: (context, myModel, child) {
        print(myModel.imageList);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            children: List.generate(myModel.imageList.length, (index) {
              PhotoDataModel model = myModel.imageList.elementAt(index);
              return Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: networkImageView(
                            imagePath: model.image, width: 200, height: 200, boxFit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10, bottom: 8, left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: textView(
                                  title: model.author,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as User;
    return args != null
        ? toolBar(
            toolBarTitle: args.name,
            onClick: () {
              performBack(context);
            },
            isImageTitle: true,
            imagePath:  args.image!=null?new File(args.image):null)
        : null;
  }

  @override
  void onScreenReady(BuildContext context) {
    _hitApi(context);
  }

  void _hitApi(BuildContext context) {
    print(BaseApis.apiUrl);
    Repository(BaseApis.apiUrl).getPhotoData<PhotoViewModel>(BaseResponseListener(
        onSuccess: (data) {
          print(data.imageList.length);
          context.read<PhotoViewModel>().addList(data.imageList);
        },
        onError: (err) {},
        isLive: true,
        showProgress: (b) {
          showProgress(b);
        }));
  }
}
