import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/addingScreenState.dart';
import 'package:VibeRentIt/views/ReusableViews/neumorphicBanner.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/bedAndWashRooms.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/carpetArea.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/imageUpload.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/location.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/parking.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/price.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/residenceName.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/residenceType.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/washRooms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddingScreen extends StatelessWidget {
  // const AddingScreen({ Key? key }) : super(key: key);

//TO GET THRE MESSAGE TO BE DISPLAYED BELOW THE BANNER
  String getDisplayMessage(AddingScreenState screenState) {
    return displayMessage[screenState];
  }

  Widget getInputWidget(AddingScreenState screenState, BuildContext context) {
    switch (screenState) {
      case AddingScreenState.residenceName:
        {
          return residenceName(context);
        }
        break;

      case AddingScreenState.residenceType:
        {
          return residenceType();
        }
        break;

      case AddingScreenState.bedRoom:
        {
          return bedAndWashRooms(context);
        }
        break;
      case AddingScreenState.washRoom:
        {
          return washRoom(context);
        }
        break;
      case AddingScreenState.carpetArea:
        {
          return carpetArea(context);
        }
        break;
      case AddingScreenState.parking:
        {
          return parking();
        }
        break;
      case AddingScreenState.location:
        {
          return locationWidgetDecider(context);
        }
        break;

      case AddingScreenState.cost:
      {
        return cost(context);
      }

      default:
        {
          return imageButton();
        }
        break;
    }
  }

  String getSvgPath(AddingScreenState screenState) {
    switch (screenState) {
      case AddingScreenState.residenceName:
        {
          return "assets/addingScreen/name.svg";
        }
        break;

      case AddingScreenState.residenceType:
        {
          return "assets/addingScreen/residenceType.svg";
        }
        break;

      case AddingScreenState.bedRoom:
        {
          return "assets/addingScreen/bedRoom.svg";
        }
        break;
      case AddingScreenState.washRoom:
        {
          return "assets/addingScreen/washRooms.svg";
        }
        break;
      case AddingScreenState.carpetArea:
        {
          return "assets/addingScreen/carpetArea.svg";
        }
        break;
      case AddingScreenState.parking:
        {
          return "assets/addingScreen/parking.svg";
        }
        break;
      case AddingScreenState.location:
        {
          return "assets/addingScreen/location.svg";
        }
        break;
        case AddingScreenState.cost:
        {
          return "assets/addingScreen/cost.svg";
        }
        break;

      default:
        {
          return "assets/addingScreen/images.svg";
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AddingScreenController()); // adding the controller to dependency
    Get.put(ResidenceDetails());
    return Scaffold(
        backgroundColor: Color(0xffedebf2),
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              
              reverse: true,
              child: GetBuilder<AddingScreenController>(builder: (controller) {
                return Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).padding.top + 20,
                    ),
                    neumorphicBanner(getSvgPath(controller.screenState)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(9, (val) {
                        return Container(
                          height: 6,
                          width: 6,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 45),
                          decoration: BoxDecoration(
                          color: val==controller.tracker?Colors.brown:Colors.orange,
                          borderRadius: BorderRadius.circular(10)

                          ),
                        );
                      }),
                    ),

                    Text(getDisplayMessage(controller.screenState)),
                    //THE INPUT WIDGET
                    getInputWidget(controller.screenState, context)
                  ],
                );
              }),
            )));
  }
}
