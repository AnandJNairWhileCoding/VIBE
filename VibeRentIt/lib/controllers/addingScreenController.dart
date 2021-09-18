

import 'package:VibeRentIt/controllers/enums/LocationWidgetState.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/controllers/enums/imageInputType.dart';
import 'package:get/get.dart';

// TO PASS THE MESSAGE TO THE USER ABOUT THE INPUT
Map displayMessage = {
  AddingScreenState.residenceName: "Please enter the name of the residence.",
  AddingScreenState.residenceType: "Select the type of residence.",
  AddingScreenState.bedRoom:"Please enter the number of bed rooms.",
  AddingScreenState.washRoom:"Please enter the number of wash rooms.",
  AddingScreenState.carpetArea:"Please enter the total carpet area.",
  AddingScreenState.parking:"Is secured vehicle parking available in the residence.",
  AddingScreenState.location:"Please provide the location of the residence.",
  AddingScreenState.images:"Please add images of the residence",
  AddingScreenState.cost:"Please enter the monthly Rent in Rupees"
};

//TO GET THE CURRENT SCREEN INPUT STATE
class AddingScreenController extends GetxController {
  var screenState =AddingScreenState.residenceName;
  int tracker=0;

  void setScreenState(AddingScreenState setState) {
    // print("setlodis $setState");
    this.screenState = setState;
    this.tracker++;
    update();
  }
}

// ++++++++++===========================+++++++++++++++++++++++++++++++++++
// TO MAINTAIN THE OBJECT OF RESIDENCE DETAILS
class ResidenceDetails {
  String name;
  String residenceType,bedRoom,washRoom;
  String carpetArea;
  String parking,locationLA,locationLO,cost;
  
}

// TO CONTROLL THE RADIO BUTTON OF RESIDENCE TYPE
class ResidenceTypeController extends GetxController {
  var selectedRadio = 0.obs;
  setRadio(int type) {
    selectedRadio.value = type;
  }
}

//TO CONTROLLTHE RADIO BUTTON OF PARKING

class ParkingController extends GetxController {
  var selectedRadio = 0.obs;
  setRadio(int type) {
    selectedRadio.value = type;
  }
}

//TO CONTROLL THE WIDGETS IN LOCATION SCREEN LIKE
// ADD-LOCATION-BUTTON,LOADING-EFFECT,CONFIRMATION-TO-NEXT-SCREEN

class LocationWidgetStateController extends GetxController {
  var widgetState = LocationWidgetState.addLocation;//this is from the enums folder in the controller

  setWidgetState(LocationWidgetState value) {
    this.widgetState = value;
    print("changing ${this.widgetState}");
    update();
  }
}

// TO CONTROLL THE LOCATION DETAILS ON-TAP ON MAP
class LocationVariables {
  var address, lat, long;

  // LocationVariables({this.sublocality,this.locality,this.subAdministrativeArea,this.pinCode});

}

class LocationController extends GetxController {
  var loc = LocationVariables();
  setLocation(List locationDetails) {
    print(">>>>>>>>>>>>>>WORKING ON SET LOCATION<<<<<<<<<<<<<<<<<<<<");

    this.loc.address = locationDetails[0];
    this.loc.lat = locationDetails[1];
    this.loc.long = locationDetails[2];
    // print(this.loc.sublocality);
    // print(this.loc.pinCode);
    update();
  }
}

// CAMERA AND GALLERY CONTROLLER
class ImageInputController extends GetxController {
  var inputType;
  var screenState=AddingImageScreenState.input;
  double percentage=0;
  List imageList=[];
  bool isInUploadingState=true;
  

    setPercentage(double type) {
    this.percentage = type;
    update();
    if(this.percentage>99){
      this.setUploadState(false);
    }
  }

    setUploadState(bool type) {
    this.isInUploadingState = type;
      // this.percentage=100;

    update();
    
  }

  setScreenState(AddingImageScreenState type) {
    this.screenState = type;
    update();
  }
  setInputType(ImageInputType type) {
    this.inputType = type;
    update();
  }

  addToList(String image) {
    this.imageList.add(image);
    update();
  }
}
