// import 'dart:html';
import 'dart:io';

import 'package:VibeRentIt/controllers/modelControllers/ResidenceDetailsListController.dart';
import 'package:VibeRentIt/models/residenceIdModel.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/showErrorMessage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/imageInputType.dart';
import 'package:VibeRentIt/views/ReusableViews/neumorphicBanner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class SelectImage extends StatelessWidget {
  // const ImageUploadScreen({ Key? key }) : super(key: key);
  final _picker = ImagePicker();
  final ImageInputController imageInputController = Get.find();

//UPLOADING WIDGET

  startUploadingData() async {
    ResidenceDetails residenceDetails = Get.find();
    ResidenceIdModel result =
        await RemoteServices.uploadResidenceDetails(residenceDetails);
    print(result);
    int listLength = imageInputController.imageList.length;

    for (var item in imageInputController.imageList) {
      await RemoteServices.uploadImage(item, result.residenceId);
      print(item);


      imageInputController.setPercentage(
          (1 / listLength) * 100 + imageInputController.percentage);


          for (var i = 0; i < 1000; i++) {
            
          }

    }

    imageInputController.setPercentage(0);
    imageInputController.setUploadState(true);
    imageInputController.imageList=[];
    imageInputController.setScreenState(
          AddingImageScreenState.input);
    Get.back();
    Get.back();
    Get.snackbar("ad posted", "",
        icon: Icon(Icons.check, color: Colors.orange),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        isDismissible: true,
        animationDuration: Duration(seconds: 1));
    ResidenceDetailsListController residenceDetailsListController =
        Get.find();
    residenceDetailsListController.fetchResidenceDetails();
  }

  Widget uploadWidget() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.03,
        ),
        neumorphicBanner("assets/addingScreen/upload.svg"),
        SizedBox(
          height: Get.height * 0.15,
        ),

//UPLOADING STATE INDICATOR(SHIMMER EFFECT)
        GetBuilder<ImageInputController>(builder: (controller) {
          return controller.isInUploadingState
              ? Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.orange,
                  child: Text(
                    "Uploading Data...",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              : Text(
                  "Uploading complete",
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
        }),

        SizedBox(
          height: Get.height * 0.03,
        ),

        GetBuilder<ImageInputController>(builder: (controller) {
          return Text("${controller.percentage}%");
        }),

        GetBuilder<ImageInputController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 95),
            child: LinearProgressIndicator(
              backgroundColor: Colors.orange[100],
              minHeight: 10,
              value: 1 / 100 * controller.percentage,
              valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
            ),
          );
        }),
      ],
    );
  }

//TO GET THE IMAGE AND ADD TO THE IMAGE LIST
  getImage() async {
    PickedFile image;
    File file;
    if (imageInputController.inputType == ImageInputType.camera) {
      image = await _picker.getImage(source: ImageSource.camera);
    } else {
      image = await _picker.getImage(source: ImageSource.gallery);
    }

    try {
      // file = File(image.path);
      imageInputController.addToList(image.path);
    } catch (e) {}
  }

  Widget getFloatingIcon() {
    if (imageInputController.inputType == ImageInputType.camera) {
      return Icon(Icons.camera_alt);
    } else {
      return Icon(Icons.photo_album);
    }
  }

//EXECUTES WHEN THE CHECK BUTTON IS PRESSED
  onpressOfCheckButton() {
    int listLength = imageInputController.imageList.length;
    print(listLength);

    if (listLength <= 0) {
      showErrorMessage("Image error!", "please select any image");
    } else {
      imageInputController.setScreenState(
          AddingImageScreenState.upoad); //setting the state to upload
      startUploadingData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getImage();
        },
        child: getFloatingIcon(),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => onpressOfCheckButton(), icon: Icon(Icons.check))
        ],
      ),
      body: GetBuilder<ImageInputController>(
        // no need to initialize Controller ever again, just mention the type
        builder: (controller) {
          // return controller.imageList.isNotEmpty & controller.screenState==AddingImageScreenState.input
          //     //DISPLAY GRID VIEW
          //     ? GridView.count(
          //         crossAxisCount: 3,
          //         children: List.generate(controller.imageList.length, (index) {
          //           return Container(
          //             decoration: BoxDecoration(
          //                 image: DecorationImage(
          //                     image: FileImage(controller.imageList[index]),
          //                     fit: BoxFit.cover)),
          //           );
          //         }),
          //       )
          //     // DISPLAY MESSAGE
          //     : uploadWidget();

          if (controller.imageList.isNotEmpty &&
              controller.screenState == AddingImageScreenState.input) {
            return GridView.count(
              crossAxisCount: 3,
              children: List.generate(controller.imageList.length, (index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(controller.imageList[index])),
                          fit: BoxFit.cover)),
                );
              }),
            );
          } else if (controller.imageList.isEmpty) {
            return Text("add image");
          } else {
            return uploadWidget();
          }
        },
      ),
    );
  }
}





//      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.camera_alt),),
//       appBar: AppBar(
//         actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
//       ),
//       body: imageInputController.imageList?
//       GridView.count(crossAxisCount: 3,children: List.generate(imageInputController.imageList.length,(index){
//         return Container();
//       } 
//     );
//   }
// }




// imageInputController.imageList
//           //DISPLAY GRID VIEW
//           ? GridView.count(
//               crossAxisCount: 3,
//               children:
//                   List.generate(imageInputController.imageList.length, (index) {
//                 return Container(
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image:
//                               FileImage(imageInputController.imageList[index]),
//                           fit: BoxFit.cover)),
//                 );
//               }),
//             )
//           // DISPLAY MESSAGE
//           : Text("")
