import 'package:VibeRentIt/controllers/localDB/localData.dart';
import 'package:VibeRentIt/controllers/signedInChecker.dart';
import 'package:VibeRentIt/views/signIn.dart';
import 'package:VibeRentIt/views/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetDecider extends StatelessWidget {
  // const WidgetDecider({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeciderController decider = DeciderController();

    return Scaffold(
      backgroundColor: Color(0xffedebf2),
      body: Obx(() {
        getIsSignedin(decider);
        return decider.signedin.value==""
            ? sh(context)
            : decider.signedin.value=="nb"
                ? nb(context)
                : si(context);
      }),
    );
  }
}
