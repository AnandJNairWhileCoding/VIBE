import 'package:geolocator/geolocator.dart';


getLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // return Future.error('Location services are disabled.');
    print("location service dissabled");
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      print("errorrrrr Location permissions are denied ");
      // return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print("${position.latitude},${position.longitude}");
  // List<Placemark> placemarks = await placemarkFromCoordinates(a.latitude,a.longitude);
  // print(placemarks.first.);
  return position;
}