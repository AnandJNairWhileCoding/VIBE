import 'package:VibeRentIt/controllers/enums/homeScreen.dart';
import 'package:VibeRentIt/controllers/localDB/localData.dart';
import 'package:VibeRentIt/controllers/modelControllers/ResidenceDetailsListController.dart';
import 'package:VibeRentIt/views/mainscreens/addingScreen/addingScreen.dart';
import 'package:VibeRentIt/views/mainscreens/detailedViewScreen.dart';
import 'package:VibeRentIt/views/widgetDecider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  // const HomePage({ Key? key }) : super(key: key);

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}


  Widget gridWidgets(ResidenceDetailsListController controller) {
    return Expanded(
      child: GridView.count(
        crossAxisSpacing: 25,
        mainAxisSpacing: 30,
        scrollDirection: Axis.vertical,
        childAspectRatio: (19 / 20),
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        children: List.generate(controller.residenceDetailList.length, (index) {
          return InkWell(onTap: (){
            Get.to(()=>DetailedViewScreen(),arguments: index);
          },
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8.0,
                        spreadRadius: 1,
                        offset: Offset(4.0, 4.0)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 8,
                        spreadRadius: 5,
                        offset: Offset(-4.0, -4.0))
                  ],
                  color: Color(0xffedebf2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
          
              //TO GET THE HEIGHT OF THE PARENT
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 9),
                      height: constraints.maxHeight * 0.60,
                      width: constraints.maxWidth * 0.80,
                      decoration: BoxDecoration( 
                          image: DecorationImage(
                            image: NetworkImage(
                                "${controller.residenceImages[index][0].image}"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                    Text(
                      "${controller.residenceDetailList[index].residenceName}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "${controller.residenceDetailList[index].bedRooms}BHK"),
                        SizedBox(
                            height: 15,
                            child: VerticalDivider(
                                color: Colors.black, thickness: 1)),
                        Text(
                            "${controller.residenceDetailList[index].residenceType}")
                      ],
                    )
                  ],
                );
              }),
            ),
          );
        }), 
      ),
    );
  }

  // LOGOUT
  logout(){
    clearData();
    Get.off(WidgetDecider());
   GoogleSignIn _googleSignIn = GoogleSignIn();
   _googleSignIn.signOut();

  }
  onTapOfCircleAvatar(){
    Get.defaultDialog(
title: "${getUserDetails()["gmail"]}",
titleStyle: TextStyle(color: Colors.brown,fontStyle: FontStyle.italic),
middleTextStyle: TextStyle(fontWeight: FontWeight.bold),

      middleText: "Logout?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: logout


    );
  }


Widget fetchingWidget(){
  return Center(
      child: Column(
        children: [
          // Spacer(),
          SizedBox(height: 200,),
          CircularProgressIndicator(),
          SizedBox(
            height: 7,
          ),
          Text("Fetching properties...",style: TextStyle(color: Colors.brown[800],fontSize: 20),),
          // Spacer()
        ],
      ),
    );
}


  @override
  Widget build(BuildContext context) {
    ResidenceDetailsListController residenceDetailsListController =
        Get.put(ResidenceDetailsListController());
    residenceDetailsListController.fetchResidenceDetails();

    return Scaffold(
      backgroundColor: Color(0xffedebf2),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddingScreen());
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: onTapOfCircleAvatar,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(getUserDetails()["image"]),
                      maxRadius: 16,
                    ),
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    // todo
                    "${greeting()},\n${getUserDetails()["name"]}",
                    style: TextStyle(
                        color: Color(0xffedebf2),
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        shadows: [
                          Shadow(
                            offset: Offset(4.0, 3.0),
                            blurRadius: 3.0,
                            color: Colors.black38,
                          ),
                          Shadow(
                            offset: Offset(-3.0, -3.0),
                            blurRadius: 8.0,
                            color: Colors.white,
                          ),
                        ]),
                  ),
                ),
                //PASSES THE CONTROLLER TO GRIDWIDGETS AUTOMATICALLY
                GetBuilder<ResidenceDetailsListController>(
                    builder: (controller) {
                      

                  if (controller.fetchingState == CompletedFetching.no) {
                    return fetchingWidget();
                  } else if(controller.residenceDetailList.length==0) {

                    return Text("no posts");

                  }
                  else{
                    return gridWidgets(controller);

                  }
                })
              ],
            ),

            // BOTTOM BUILDINGS SVG IMAGE
            //  ,
          ],
        ),
      ),
    );
  }
}
