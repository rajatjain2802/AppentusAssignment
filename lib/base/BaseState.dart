import 'dart:async';
import 'dart:io';


import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/widget/CircularProgressbar.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool _isShowing = false;
  bool _isFirstTime = true;
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  StreamController<bool> _streamController = new StreamController<bool>.broadcast();

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          key: scaffoldKey,
          appBar: getToolBar(context),
          floatingActionButton: getFloatingButton(context),
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: getBuildWidget(context),
              ),
              StreamBuilder<bool>(
                  stream: _streamController.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container();
                      default:
                        return snapshot.data ? circularProgress(progressColor: Colors.blue) :
                        Container();
                    }
                  }),
              _isFirstTime ? _callApiWidget(context) : Container(),
            ],
          ),
          drawer: getDrawer(context),
        ),
      ),
      onWillPop: () async {
        performBack(context);
        return false;
      },
    );
  }

  performBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      onBackPressed(context);
    } else {
      exit(0);
    }
  }

  openDrawer() {
    scaffoldKey.currentState.openDrawer();
  }

  Drawer getDrawer(BuildContext context) {
    return null;
  }

  FloatingActionButton getFloatingButton(BuildContext context) {
    return null;
  }

  AppBar getToolBar(BuildContext context);

  Widget getBuildWidget(BuildContext context);

  void onBackPressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onScreenReady(BuildContext context);

  Widget _callApiWidget(BuildContext ctx) {
    _isFirstTime = false;
    onScreenReady(ctx);
    return Container();
  }

  showProgress(bool b) {
    if (_isShowing != b && !_streamController.isClosed) {
      _isShowing = b;
      Future.delayed(Duration(milliseconds: 1), () {
        _streamController.add(_isShowing);
      });
    }
  }

  showSnackBar(String str, {Color bgColor = AppColor.red}) {
    var snackbar = new SnackBar(
      content: new Text(str),
      duration: Duration(seconds: 2),
      backgroundColor: bgColor,
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
