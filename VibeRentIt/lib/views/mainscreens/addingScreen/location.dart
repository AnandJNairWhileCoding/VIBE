import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/LocationWidgetState.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/controllers/getLocation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget locationWidgetDecider(BuildContext context) {
  Get.put(LocationWidgetStateController());
  // lwsc.setWidgetState(LocationWidgetState.addLocation);

  return GetBuilder<LocationWidgetStateController>(builder: (controller) {
    if (controller.widgetState == LocationWidgetState.addLocation) { 
      return location(context);
    } else if (controller.widgetState == LocationWidgetState.fetchingLocation) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            CircularProgressIndicator(),
            Spacer(
              flex: 1,
            ),
            Text(
              "Fetching location details please wait...",
              style: TextStyle(color: Colors.orange),
            ),
            Spacer(flex: 3)
          ],
        ),
      );
    } else {
      LocationController locationController = Get.find();

      return SizedBox(
        
        height: MediaQuery.of(context).size.height * 0.45,
        child: Column(
          
          children: [
            Spacer(flex: 3,),
            Chip(
                  padding: EdgeInsets.all(5),
                  avatar: CircleAvatar(
                      child: Icon(
                    Icons.location_on,
                    color: Colors.brown,
                  )),
                  backgroundColor: Colors.orange[200],
                  label:  Text(
                      '${locationController.loc.address}',
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.brown),
                    ),
                  
                ),
                // Spacer(flex: 1),
                SizedBox(height: 5,),
            
                     locationButton("Edit location"),
                Spacer(flex: 3,),
                ElevatedButton(
                  onPressed: (){
                    AddingScreenController addingScreenController= Get.find();
                    LocationController locationController=Get.find();//to update the the details in residence details class
                    ResidenceDetails residenceDetails=Get.find();
                    residenceDetails.locationLA=locationController.loc.lat.toString();
                    residenceDetails.locationLO=locationController.loc.long.toString();
                    print(residenceDetails.bedRoom);
                    print(residenceDetails.locationLA);
                    addingScreenController.setScreenState(AddingScreenState.images);

                  },
                  child: Text("Continue"),//CONTINUE BUTTON
                ),
            Spacer(flex: 4,)
          ],
        ),
      );
    }
  });
}

Widget location(BuildContext context) {
  // GoogleMapController _controller;

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.45,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Spacer(),

        locationButton("Add location")

        // SizedBox(
      ],
    ),
  );
}


//ADD LOCATION BUTTON
Widget locationButton(String buttonName){
  return InkWell(
          onTap: performAction,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(width: 4.0, color: Colors.orange),
              borderRadius: BorderRadius.circular(50),
              // color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: Colors.deepOrangeAccent,
                ),
                Text(buttonName
                  ,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.brown),
                )
              ],
            ),
          ),
        );
}

performAction() async {
  
  LocationController locationController = Get.put(LocationController());

  LocationWidgetStateController lwsc =
      Get.find(); //getting the instance from the dependency--
  lwsc.setWidgetState(LocationWidgetState
      .fetchingLocation); //--to set the next state of the location widget
  
  Position latlong = await getLocation();
  List<Placemark> placemarks = await placemarkFromCoordinates(
      latlong.latitude, latlong.longitude); //coordinates converted to address
  locationController.setLocation([
    '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}',
    latlong.latitude,
    latlong.longitude
    // (latlong.latitude, latlong.
  ]);

  Get.to(() => SelectLocation(),
      arguments: latlong, transition: Transition.downToUp);
}



// THIS IS THE SCREEN WHERE THE MAP WILL BE DISPLAYED
class SelectLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoogleMapController _controller;
    LocationController locationController = Get.find();
    // var address = locationController.loc.value;

    return WillPopScope(
      onWillPop: () async {
        LocationWidgetStateController lwsc = Get.find();
        lwsc.setWidgetState(LocationWidgetState.confirmation);
        Get.back();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                LocationWidgetStateController lwsc = Get.find();
                lwsc.setWidgetState(LocationWidgetState.confirmation);
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          title: Text(
            "Select Location",
            style: TextStyle(color: Color(0xffF9A826)),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                // height: 500,
                // width: 10,
                child: GetBuilder<LocationController>(
                    builder: (value) => GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(Get.arguments.latitude,
                                  Get.arguments.longitude),
                              zoom: 16),
                          mapType: MapType.normal,
                          onMapCreated: (controller) {
                            _controller = controller;
                          },
                          markers: {
                            Marker(
                              markerId: MarkerId("marker"),
                              position: LatLng(value.loc.lat, value.loc.long),
                            )
                          },
                          //PASSING THE COORDINATES ON-TAP ACTION
                          onTap: (cord) async {
                            // print(cord);
                            //GETTING THE ADDRESS FROM THE COORDINATES
                            List<Placemark> placemarks;
                            try {
                              placemarks = await placemarkFromCoordinates(
                                  cord.latitude, cord.longitude);
                            } on Exception catch (e) {
                              print('e');
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                              print("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");

                              return 0;
                            }

                            locationController.setLocation([
                              '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}',
                              cord.latitude, //TO SET THE MARKER ON THE MAP
                              cord.longitude //TO SET THE MARKER ON THE MAP
                            ]);
                            // print(placemarks.first.locality);
                            _controller
                                .animateCamera(CameraUpdate.newLatLng(cord));
                          },
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.topCenter,
                child: Chip(
                  padding: EdgeInsets.all(5),
                  avatar: CircleAvatar(
                      child: Icon(
                    Icons.location_on,
                    color: Colors.brown,
                  )),
                  backgroundColor: Colors.orange[200],
                  label: GetBuilder<LocationController>(
                    builder: (value) => Text(
                      '${value.loc.address}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
