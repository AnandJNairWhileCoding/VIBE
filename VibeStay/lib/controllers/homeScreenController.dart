import 'package:VibeStay/controllers/localDB/localDataBase.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  String address = "";
  
  
  initializeLocation() async {
    var locationDetails = getLocationDetails();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        locationDetails["lattitude"],
        locationDetails["longitude"]); //coordinates converted to address
    this.address =
        '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}';
    update();
  }

setLocationWithCoordinates(double lattitude,double longitude)async{
List<Placemark> placemarks = await placemarkFromCoordinates(
        lattitude,
        longitude); //coordinates converted to address
    this.address =
        '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}';
    update();
}
  

  setLocation(String locationDetails) {
    print(">>>>>>>>>>>>>>WORKING ON SET LOCATION<<<<<<<<<<<<<<<<<<<<");

    this.address = locationDetails;

    update();
  }
}
