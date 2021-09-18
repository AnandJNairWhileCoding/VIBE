import 'package:VibeStay/controllers/enums/locationFetchingState.dart';
import 'package:VibeStay/controllers/homeScreenController.dart';
import 'package:VibeStay/controllers/localDB/localDataBase.dart';
import 'package:VibeStay/controllers/updateLocationController.dart';
import 'package:VibeStay/views/signIn.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UpdateLocation extends StatelessWidget {
  const UpdateLocation({Key? key}) : super(key: key);


  logout(){
    clearData();
    Get.off(()=>SignIn());
   GoogleSignIn _googleSignIn = GoogleSignIn();
   _googleSignIn.signOut();

  }


  onTapOfLogout(){
    Get.defaultDialog(
title: "${getUserDetails()["gmail"]}",
titleStyle: TextStyle(color: Colors.brown,fontStyle: FontStyle.italic),
middleTextStyle: TextStyle(fontWeight: FontWeight.bold),

      middleText: "Logout?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: logout


    );
  }


  Widget mainStackWidget() {
    GoogleMapController? _controller;
    LocationController locationController = Get.find();

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            // height: 500,
            // width: 10,
            child: GetBuilder<UpdateLocationController>(
                builder: (value) => GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              value.lattitude ?? 0.0, value.longitude ?? 0.0),
                          zoom: 16),
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        _controller = controller;
                      },
                      markers: {
                        Marker(
                          markerId: MarkerId("marker"),
                          position: LatLng(
                              value.lattitude ?? 0.0, value.longitude ?? 0.0),
                        )
                      },
                      //PASSING THE COORDINATES ON-TAP ACTION
                      onTap: (cord) async {
                        _controller
                            ?.animateCamera(CameraUpdate.newLatLng(cord));
                        // print(cord);
                        //GETTING THE ADDRESS FROM THE COORDINATES
                        List<Placemark> placemarks;
                        try {
                          placemarks = await placemarkFromCoordinates(
                              cord.latitude, cord.longitude);
                        } on Exception catch (e) {
                          print('$e');
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
                          print(
                              "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");

                          return null;
                        }

                        locationController.setLocation(
                          '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}',

                          //TO SET THE MARKER ON THE MAP
                        );

                          setLocationDetails(cord.latitude, cord.longitude);
                        // print(placemarks.first.locality);

                        value.setLatLon(cord.latitude, cord.longitude);
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
                  '${value.address}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget fetchingStateWidget() {
    return Column(
      children: [Text("Fetching location")],
    );
  }

  @override
  Widget build(BuildContext context) {
    // UpdateLocationController updateLocationController = Get.find();
    UpdateLocationController updateLocationController =
        Get.put(UpdateLocationController());
    LocationFetchingController locationFetchingController =
        Get.put(LocationFetchingController());
    updateLocationController.initializeLatLong(locationFetchingController);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.check))
          ],
        ),
        body: GetBuilder<LocationFetchingController>(builder: (controller) {
          return controller.fetchingState == LocationFetchingState.fetching
              ? fetchingStateWidget()
              : mainStackWidget();
        }));
  }
}
