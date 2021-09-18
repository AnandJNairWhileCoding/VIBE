import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/showErrorMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// String getResidenceType(var selectedInput){
//       if (selectedInput==1){

//       }
// }



onPressOfContinue(List residenceTypes,int selectedInput){
              ResidenceDetails residenceDetails=Get.find();
            try {
            residenceDetails.residenceType=residenceTypes[selectedInput-1];//the below tow lines will execute only if the user has selected an input.
            AddingScreenController addingScreenController= Get.find();
            addingScreenController.setScreenState(AddingScreenState.bedRoom);
              
            } catch (e) {
                  showErrorMessage("Oops!", "Please select the Residence type");
            }
            print(residenceDetails.residenceType);
}

Widget residenceType() {
  ResidenceTypeController residenceType = ResidenceTypeController();
  List residenceTypes = ["Appartment", "Villa", "Bunglav"];
  var selectedInput;

  // return Obx(builder)(
  //   Column(
  //     children: [Radio(value: 1, groupValue: _value, onChanged: (value) {})],
  //   ),
  // );

  return Obx(() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
      child: Column(
        children: [
          Column(
            children: List.generate(3, (index) {
              return 
                  RadioListTile(
                      value: index + 1,
                      groupValue: residenceType.selectedRadio.value,
                      title: Text(residenceTypes[index]),
                      onChanged: (type) {
                        residenceType.setRadio(type);
                        selectedInput=type;//storing the input to process it later wwhen the continue button is clicked
                        print(type);
                      });
                  
                
              
            }),
          ),
          ElevatedButton(onPressed: ()=>onPressOfContinue(residenceTypes, selectedInput)
          , child: Text("Continue"))
        ],
      ),
    );
  });
}
