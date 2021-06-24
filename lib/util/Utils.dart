import 'dart:io';

import 'package:appentus_assignment/util/Location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';



// Check Internet Connection
Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

// check Map and value  and if null fill with ""
String getFieldValue(Map map, String key) {
  String str = '';
  if (map.containsKey(key)) {
    String s = map[key];
    if (s != null) {
      str = s.toString();
    }
  }
  return str;
}

int getFieldValueInteger(Map map, String key) {
  int value = 0;
  if (map.containsKey(key)) {
    int s = map[key];
    if (s != null) {
      value = s;
    }
  }
  return value;
}
Future<PickedFile> chooseFile({ImageSource imageSource = ImageSource.gallery}) async {
  PickedFile image = await ImagePicker().getImage(source: imageSource);
  return image;
}
Future<Map<String, dynamic>> getUserLocation() async {
  print("getLocation");
  Location userLocation = new Location();
  Map<String, dynamic> locationMap = new Map();
  LocationPermission hasLocationPermission = await GeolocatorPlatform.instance.checkPermission();

  if (hasLocationPermission == LocationPermission.always ||
      hasLocationPermission == LocationPermission.whileInUse) {
    try {
      Position location = await GeolocatorPlatform.instance.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: Duration(seconds: 20));
      if (location != null) {
        userLocation = new Location();
        userLocation.latitude = location.latitude;
        userLocation.longitude = location.longitude;
      } else {
        userLocation = null;
      }
    } catch (err) {
      userLocation = null;
    }
  } else {
    hasLocationPermission = await GeolocatorPlatform.instance.requestPermission();

    if (hasLocationPermission == LocationPermission.whileInUse ||
        hasLocationPermission == LocationPermission.always) {
      try {
        Position location = await GeolocatorPlatform.instance.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Duration(seconds: 20));
        if (location != null) {
          userLocation = new Location();
          userLocation.latitude = location.latitude;
          userLocation.longitude = location.longitude;
        } else {
          userLocation = null;
        }
      } catch (err) {
        userLocation = null;
      }
    } else {
      userLocation = null;
    }
  }
  locationMap["location"] = userLocation;
  locationMap["status"] = hasLocationPermission ?? LocationPermission.denied;
  return locationMap;
}