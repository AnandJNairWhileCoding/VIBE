import 'package:get/get.dart';

class DeciderController extends GetxController {
   var signedin="".obs;
  
	
  void setSignedIn(String setLod){
    print("setlodis $setLod");
   signedin.value= setLod; 
   
  }}