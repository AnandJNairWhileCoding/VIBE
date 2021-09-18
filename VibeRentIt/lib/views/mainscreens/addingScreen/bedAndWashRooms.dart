// import 'package:VibeRentIt/views/ReusableViews/neumorphicBanner.dart';
import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/views/ReusableViews/neumorphicTextField.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/showErrorMessage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

TextEditingController controller = TextEditingController();

onPressOfContinue(TextEditingController controller) {
  try {

    if (controller.text == "") {
      showErrorMessage("Oops!", "Please enter the number of bed rooms");
    } else {
    int.parse(controller.text);//to check whether the user has entered an valid input

      AddingScreenController addingScreenController = Get.find();
      addingScreenController.setScreenState(AddingScreenState.washRoom);
      ResidenceDetails residenceDetails = Get.find();
      residenceDetails.bedRoom  = controller.text;
      controller.text = "";
      controller = null;
    }
  } catch (e) {
      showErrorMessage("Oops!", "Invalid input");

  }
}

Widget bedAndWashRooms(BuildContext context) {
  return Column(
    children: [
      //TEXT INPUT FIELD
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.20,
            vertical: MediaQuery.of(context).size.width * 0.10),
        child: neumorphicTextField(
            "No of Bedrooms", controller, TextInputType.number, 1),
      ),

      //===============//

      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: ()=>onPressOfContinue(controller),
          child: Text("Continue"),
          style: ButtonStyle(),
        ),
      ),
    ],
  );
}
