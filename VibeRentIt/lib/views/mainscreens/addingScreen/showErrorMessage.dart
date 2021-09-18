import 'package:get/get.dart';
import 'package:flutter/material.dart';


showErrorMessage(String title,String text){
      Get.snackbar(title, text,
        icon: Icon(Icons.warning, color: Colors.orange),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        isDismissible: true,
        animationDuration: Duration(seconds: 1));
}