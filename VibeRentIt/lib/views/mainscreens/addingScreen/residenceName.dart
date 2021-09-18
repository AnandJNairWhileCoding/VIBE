// import 'package:VibeRentIt/views/ReusableViews/neumorphicBanner.dart';
import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/views/ReusableViews/neumorphicTextField.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/showErrorMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController controller = TextEditingController();

onPressOfContinue(TextEditingController controller) {
  if (controller.text == "") {
   showErrorMessage("Oops!", "The name cannot be empty");
  } else {
    AddingScreenController addingScreenController = Get.find();
    addingScreenController.setScreenState(AddingScreenState.residenceType);
    ResidenceDetails residenceDetails = Get.find();
    residenceDetails.name = controller.text;
    controller.text="";
    controller=null;
  }
 
  
}

Widget residenceName(BuildContext context) {
  return Column(
    children: [
      //TEXT INPUT FIELD
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
        child: neumorphicTextField(
            "Residence name", controller, TextInputType.name, 50),
      ),
      //===============//

      ElevatedButton(
        onPressed: () => onPressOfContinue(controller),
        child: Text("Continue"),
        style: ButtonStyle(),
      ),
      SizedBox(
        height: 5,
      )
    ],
  );
}
