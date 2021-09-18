import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/showErrorMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

onPressOfContinue(List parking, int selectedInput) {
  ResidenceDetails residenceDetails = Get.find();
  try {
    residenceDetails.parking = parking[selectedInput -1]; //the below tow lines will execute only if the user has selected an input.
    AddingScreenController addingScreenController = Get.find();
    addingScreenController.setScreenState(AddingScreenState.cost);
  } catch (e) {
    showErrorMessage("Oops!", "Please select an option");
  }
  print(residenceDetails.residenceType);
}

Widget parking() {
  ParkingController parking = ParkingController();
  List parkingAvailability = ["Yes", "No"];
  var selectedInput;

  // return Obx(builder)(
  //   Column(
  //     children: [Radio(value: 1, groupValue: _value, onChanged: (value) {})],
  //   ),
  // );

  return Obx(() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Column(
        children: [
          Column(
            children: List.generate(2, (index) {
              return RadioListTile(
                  value: index + 1,
                  groupValue: parking.selectedRadio.value,
                  title: Text(parkingAvailability[index]),
                  onChanged: (type) {
                    parking.setRadio(type);
                    selectedInput = type;
                  });
            }),
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () =>
                  onPressOfContinue(['True','False'], selectedInput),
              child: Text("Continue"))
        ],
      ),
    );
  });
}
