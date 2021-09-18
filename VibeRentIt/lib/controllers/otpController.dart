import 'package:VibeRentIt/controllers/localDB/localData.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:VibeRentIt/views/mainscreens/home.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpController {
  bool loading;
  bool isPhone;
  OtpController({this.loading, this.isPhone});
}

class Controller extends GetxController {
  var otpObj = OtpController(
      loading: false, isPhone: true); 

  void setLoding(bool setLod) {
    otpObj.loading = setLod; // use .value and access any variables of the class
    update();
  }

  void setIsPhone(bool setPh) {
    otpObj.isPhone = setPh;
    update();
  } // use .value and access any variables of the class

}

class OtpLogics {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;

  void submitOtp(String otp, Controller controller) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    print("OTP OTP OTP OTP OTP OTP OTP  $otp");

    


    print(verificationId);
    // setState(() {
    //   showLoading = true;
    // });
    controller.setLoding(true);

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      // setState(() {
      //   showLoading = false;
      // });
      controller.setLoding(false);

      if (authCredential?.user != null) {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));,
        //TODO
        print("working");
        print(authCredential.user.phoneNumber);
        setPhoneNumber("${authCredential.user.phoneNumber}");
      var userDetail=getUserDetails();
        userDetail["phoneNumber"]="${getPhoneNumber()}";
        print(userDetail);
        await RemoteServices.createOwner(userDetail);
        
          // Get.off(()=>WelcomeS);
          print("poosted");
          Get.off(()=>HomePage());
        //diolog 
         
          Get.defaultDialog(
title: "You have successfully signedin!",
titleStyle: TextStyle(color: Colors.brown,fontStyle: FontStyle.italic),
middleTextStyle: TextStyle(fontWeight: FontWeight.bold),

      middleText: "",
      textConfirm: "Okay",
      textCancel: "Cancel",
      onConfirm: (){
        Get.back();
      }


    );

        
        
        
      }
    } on FirebaseAuthException catch (e) {
      // setState(() {
      //   showLoading = false;
      // });
      controller.setLoding(false);
      print("FirebaseAuthExceptionghgfhgfhg");
      Get.snackbar("error", "please enter a valid OTP",
        icon: Icon(Icons.warning, color: Colors.orange),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        isDismissible: true,
        animationDuration: Duration(seconds: 1));

      // _scaffoldKey.currentState
      //     .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void getOtp(String phoneNumber, Controller controller) async {
    // setState(() {
    //   showLoading = true;
    // });
    controller.setLoding(true);
    print(">>>>>>>>>>>>>${controller.otpObj}<<<<<<<<<<<<<");

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        // setState(() {
        //   showLoading = false;
        // });
        // signInWithPhoneAuthCredential(phoneAuthCredential);
        // Controller controller=Get.find();☺
        controller.setLoding(false);
      },
      verificationFailed: (verificationFailed) async {
        // setState(() {
        //   showLoading = false;
        // });
        // _scaffoldKey.currentState.showSnackBar(
        //     SnackBar(content: Text(verificationFailed.message)));
        controller.setLoding(false);
        print("Verification Failed");
        print(verificationFailed);
      },
      codeSent: (verificationId, resendingToken) async {
        // setState(() {
        //   showLoading = false;
        //   currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
        //   this.verificationId = verificationId;
        // });
        print("codesent");
        controller.setLoding(false);
        print(">>>>>>>>>>>>>${controller.otpObj}<<<<<<<<<<<<<");

        print(controller.otpObj.loading);
        print(controller.otpObj.isPhone);
        controller.setIsPhone(false);
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        this.verificationId = verificationId;
      },
    );
  }
}
