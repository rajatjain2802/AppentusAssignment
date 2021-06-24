import 'dart:io';

import 'package:appentus_assignment/base/BaseState.dart';
import 'package:appentus_assignment/data/local/UserModel.dart';
import 'package:appentus_assignment/data/local/dao/UserDao.dart';
import 'package:appentus_assignment/res/AppColor.dart';
import 'package:appentus_assignment/util/Location.dart';
import 'package:appentus_assignment/util/Utils.dart';
import 'package:appentus_assignment/widget/BigButtonView.dart';
import 'package:appentus_assignment/widget/Toolbar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
/*
* Created By Rajat Jain 24/06/2021
* */
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeScreen> {
  Location location;
  GoogleMapController controller;
  Set<Marker> _markers = {};
  User user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget getBuildWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: location != null
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(location.latitude, location.latitude), zoom: 12.0),
                    mapType: MapType.normal,
                    markers: _markers,
                    onMapCreated: (controls) {
                      controller = controls;
                      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(location.latitude, location.longitude), zoom: 18.0)));
                      _markers.add(_createMarker().first);
                      setState(() {});
                    },
                    zoomControlsEnabled: false,
                  )
                : Container()),
        Container(
          color: Colors.black26,
          child: bigButtonView(
            label: "Go to Second Screen",
            isEnabled: true,
            cornerRadius: 40,
            onClick: () {
              Navigator.pushNamed(context, "/photo", arguments: user);
            },
            labelColor: AppColor.primary,
            margin: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
          ),
        )
      ],
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return user != null
        ? toolBar(
            toolBarTitle: user.name,
            onClick: () {
              performBack(context);
            },
            isImageTitle: true,
            imagePath: new File(user.image))
        : null;
  }

  @override
  void onScreenReady(BuildContext context) async {
    final args = ModalRoute.of(context).settings.arguments as String;
    user = await UserDao().getUserDetails(args);
    setState(() {});
  }

  void getLocation() async {
    showProgress(true);
    Map<String, dynamic> map = await getUserLocation();
    if (map['status'] == LocationPermission.denied ||
        map['status'] == LocationPermission.deniedForever) {
      showProgress(false);
      showSnackBar("Please enable location permission for App from Settings");
    } else {
      if (map["location"] != null) {
        location = map["location"];
        setState(() {});
        showProgress(false);
      } else {
        showProgress(false);
        showSnackBar("Error while getting location");
      }
    }
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("currentLocation"),
          position: LatLng(location.latitude, location.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: "${location}"))
    ].toSet();
  }
}
