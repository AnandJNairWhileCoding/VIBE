import 'package:VibeRentIt/controllers/otpController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class OtpScreen extends StatelessWidget {
  // Welcome({ Key? key }) : super(key: key);
  TextEditingController TextController = TextEditingController();
  

  OtpLogics otpLogics = OtpLogics();//this contains getOtp and SubmitOtp functions


// =================== PHONE_NUMBER AND OTP INPUT WIDGET ================================
  Widget inputWidget(String buttonName, String hintText,Controller widgetController) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextField(
              keyboardType: TextInputType.phone,
              controller: TextController,
              decoration: InputDecoration(
                hintText: hintText,
              )),
        ),
        SizedBox(
          height: 20,
          width: 0,
        ),
        ElevatedButton(
            onPressed: () async {
              if (buttonName == "Get OTP") {
                otpLogics.getOtp(TextController.text.trim(), widgetController);
              } else {
                
                otpLogics.submitOtp(
                    TextController.text.trim(), widgetController);
              }
            },
            child: Text(buttonName))
      ],
    );
  }

  Widget otpInputWidget(Controller ctr) {
    return inputWidget("Submit", "Enter OTP",ctr);
  }

  Widget phoneInputWidget(Controller ctr) {
    return inputWidget("Get OTP", "Enter Phone number",ctr);
  }

// =================================SCHIMMER EFFECT Widget======================

  Widget schimmerEffect(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400],
      highlightColor: Color(0xffedebf2),
      child: Column(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.65,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 35,
            width: MediaQuery.of(context).size.width * 0.20,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  // var widgetController = Get.put(Controller());

    return Scaffold(
      backgroundColor: Color(0xffedebf2),
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                Center(
                  child: Container(
                    child: Container(
                        height: 220,
                        width: 230,
                        decoration: BoxDecoration(
                            color: Colors.black12, shape: BoxShape.circle)),
                    height: 220,
                    width: 230,
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.orange),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/auth.png"),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15.0,
                              offset: Offset(4.0, 14.0)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 16.0,
                              offset: Offset(-4.0, -4.0))
                        ]),
                  ),
                ),

                // greeting-WIDGET
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    "Hey, ${Get.arguments} nice to meet you!",
                    style: TextStyle(color: Colors.brown),
                  ),
                ),


                GetBuilder<Controller>( // specify type as Controller
  init: Controller(), // intialize with the Controller
  builder: (widgetController) {
    return widgetController.otpObj.loading
                    ? schimmerEffect(context)
                    : widgetController.otpObj.isPhone
                        ? phoneInputWidget(widgetController)
                        : otpInputWidget(widgetController);
  }
)

              // Obx(()
              // {return widgetController.otpObj.loading
              //       ? schimmerEffect(context)
              //       : widgetController.otpObj.isPhone
              //           ? phoneInputWidget(widgetController)
              //           : otpInputWidget(widgetController);}) ,
                        // Obx(builder)
                        // GetX(builder: builder) 

                        
              ],
            ),
          )),
    );
  }
}



















