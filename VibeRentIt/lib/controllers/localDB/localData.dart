
import 'package:shared_preferences/shared_preferences.dart';
import 'package:VibeRentIt/controllers/signedInChecker.dart';
import 'package:get/get.dart';


setIsSignedin() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isSignedin", true);
}

Future getIsSignedin(DeciderController decider) async{

  SharedPreferences prefs = Get.put(await SharedPreferences.getInstance());
  bool ppp=prefs.getBool("isSignedin")??false;
  // decider.setSignedIn(ppp);
  
  return rot(ppp,decider);
  
}

bool rot(bool b,DeciderController decider){
  print("returning ${b??"nullllll"}");
  decider.setSignedIn(b?"nb":"si");

  return b;
}


setOwnerDetails(String gMail, String  name, String image) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("gMail", gMail);
  prefs.setString("name", name);
  prefs.setString("image", image);

}
setPhoneNumber(String phone){
  SharedPreferences prefs = Get.find();
  prefs.setString("phoneNumber", phone);

}
getPhoneNumber(){
  SharedPreferences prefs = Get.find();
  return prefs.get("phoneNumber");
  
}
 getUserDetails() {
  SharedPreferences prefs = Get.find();
  
 return{"gmail":prefs.get("gMail"),
  "name":prefs.get("name"),
  "image":prefs.get("image")}; 

}

clearData()async{
  
  SharedPreferences prefs = Get.find();
  
  
  
  await prefs.clear() ;


}
