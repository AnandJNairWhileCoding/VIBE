import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/enums/imageInputType.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/selectImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget imageButton() {
  return SizedBox(
    height: Get.height * 0.45,
    child: Column(
      children: [
        Spacer(),
        InkWell(
          onTap: () {
            Get.bottomSheet(Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                //SHEET CONTETS
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 10,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[600],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            ImageInputController imageInputController =
                                Get.put(ImageInputController());
                            imageInputController
                                .setInputType(ImageInputType.camera);
                                Get.off(()=>SelectImage());
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.orange,
                            size: 50,
                          )),
                      IconButton(
                          onPressed: () {
                            ImageInputController imageInputController =
                                Get.put(ImageInputController());
                            imageInputController
                                .setInputType(ImageInputType.gallery);
                                Get.off(()=>SelectImage());
                          },
                          icon: Icon(
                            Icons.photo,
                            color: Colors.orange,
                            size: 50,
                          ))
                    ],
                  ),
                ],
              ),
            ));
          },
          child: Container(
            // height:20,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(width: 5.0, color: Colors.orange),
              borderRadius: BorderRadius.circular(50),
              // color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.photo,
                  color: Colors.deepOrangeAccent,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "Add image",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )
              ],
            ),
          ),
        ),
        Spacer()
      ],
    ),
  );
}





//=======================================================================
//==========IMAGE UPLOAD SCREEN==========================================
//=======================================================================



