import 'package:VibeRentIt/controllers/localDB/localData.dart';
import 'package:VibeRentIt/controllers/modelControllers/userModelController.dart';
import 'package:VibeRentIt/models/ownerModel.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:VibeRentIt/views/ReusableViews/neumorphicBanner.dart';
import 'package:VibeRentIt/views/mainscreens/home.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class WelcomeScreen extends StatelessWidget {
// const WelcomeScreen({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(top: false,
//         child: Column(
//           children: [
//             SizedBox(height: MediaQuery.of(context).padding.top + 20),
//             neumorphicBanner("assets/welcome.png"),

//           ],
//         )),
//     );
//   }
// }

Widget nb(BuildContext context) {
  SharedPreferences prefs = Get.find();

  return SafeArea(
      top: false,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          neumorphicBanner("assets/welcome.svg"),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome back ${prefs.get("name")},please press continue to home screen",
                textAlign: TextAlign.center,
              style: TextStyle( fontWeight: FontWeight.bold,fontSize: 15),),
            ),
          ),

          SizedBox(height: 100,),
          ElevatedButton(
              onPressed: () {
                Get.off(() => HomePage());
              },
              child: Text("continue")),
          // ElevatedButton(onPressed: ()async{
          //   // UserModelController umc=UserModelController();
          //   //  umc.fetchUser();
          //     // RemoteServices.postAnswer("this is the answer from flutter");

          // }, child: Text("api"))
        ],
      ));
}

// shimmer effect for the starting of app
Widget sh(BuildContext context) {
  return SafeArea(
      top: false,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400],
        highlightColor: Color(0xffedebf2),
        child: Text("VIBE RENTIT"),
      ));
}
