import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';

setIsSignedin() {
    SharedPreferences prefs = Get.find();

  prefs.setBool("isSignedin", true);
}

bool getIsSignedin() {
  SharedPreferences prefs = Get.find();

  bool isSignedin = prefs.getBool("isSignedin") ?? false;
  // decider.setSignedIn(ppp);

  return isSignedin;
}

setUserDetails(String gMail, String? name, String? image) async {
  SharedPreferences prefs = Get.find();

  prefs.setString("gMail", gMail);
  prefs.setString("name", name??"");
  prefs.setString("image", image??'');
}

getUserDetails() {
  SharedPreferences prefs = Get.find();

  return {
    "gmail": prefs.get("gMail"),
    "name": prefs.get("name"),
    "image": prefs.get("image")
  };
}

setLocationDetails(double la, double lo){
  SharedPreferences prefs = Get.find();

  prefs.setDouble("lattitude", la);
  prefs.setDouble("longitude", lo);
  
  
}

getLocationDetails() {
  SharedPreferences prefs = Get.find();

  return {
    "lattitude": prefs.get("lattitude"),
    "longitude": prefs.get("longitude"),
  };
}


setLocationState(bool value){
  SharedPreferences prefs=Get.find();
  prefs.setBool("isLocationset", value);
}

isLocationDetailsSet(){
  SharedPreferences prefs=Get.find();

  return prefs.get("isLocationset")??false;
}

clearData() async {
  SharedPreferences prefs = Get.find();
  await prefs.clear();
}
