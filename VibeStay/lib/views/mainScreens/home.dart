import 'package:VibeStay/controllers/enums/homeScreen.dart';
import 'package:VibeStay/controllers/homeScreenController.dart';
import 'package:VibeStay/controllers/localDB/localDataBase.dart';
import 'package:VibeStay/controllers/modelControllers/residenceDetailsListControllers.dart';
import 'package:VibeStay/views/mainScreens/detailedViewScreen.dart';
// import 'package:VibeStay/controllers/updateLocationController.dart';
// import 'package:VibeStay/services/fetchLocation.dart';
import 'package:VibeStay/views/mainScreens/updateLocation.dart';
import 'package:VibeStay/views/signIn.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

onTapofUpdateLocation(){


Get.back();
Get.to(()=>UpdateLocation());
}
 
onTapOfLogout(){

    clearData();
    Get.off(()=>SignIn());
   GoogleSignIn _googleSignIn = GoogleSignIn();
   _googleSignIn.signOut();

  
  
}
 

//===================================================================
 onTapOfCircleAvatar(){
   var user=getUserDetails();
    Get.bottomSheet(
      Container(
      decoration: BoxDecoration(
       
        color: Color(0xffedebf2),
        
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
        height: 300,
        child: Column(
          children: [
            
             Padding(
               padding: const EdgeInsets.only(top: 10,bottom: 10),
               child: CircleAvatar(
                        backgroundImage: NetworkImage(user['image']),
                        maxRadius: 30,
                      ),
             ),
             Text("${user['gmail']}",
             style: TextStyle(
               color: Colors.brown,
               fontStyle: FontStyle.italic,
               fontWeight: FontWeight.w400,
               fontSize: 20

             ),),
             Padding(
               padding: const EdgeInsets.only(top: 15,bottom: 15),
               child: Chip(elevation: 5,
                    padding: EdgeInsets.all(5),
                    avatar: CircleAvatar(backgroundColor: Color(0xffedebf2),
                        child: Icon(
                      Icons.location_on,
                      color: Colors.deepOrange,
                    )),
                    backgroundColor: Color(0xffedebf2),
                    label: GetBuilder<LocationController>(
                      builder: (value) => Text(
                        '${value.address}',
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
             ),
            //  SizedBox(
            //    width: Get.width*0.70,
            //    child: Divider(thickness: 1,color: Colors.black,)),

             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                 Column(
                   children: [
               IconButton(onPressed: onTapOfLogout, icon: Icon(Icons.logout,size: 40,),color: Colors.orange,),
               Text("Logout",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15),)

                   ],
                 ),
                 Column(
                   children: [
               IconButton(onPressed: onTapofUpdateLocation, icon: Icon(Icons.location_on,size: 40,),color: Colors.orangeAccent,),
               Text("Update Location",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15))

                   ],
                 )
               ],),
             )
          ],
        ),),
      // ),backgroundColor:Colors.black38,
      elevation: 10 
    );
  }

  // ==================================================================
  // =================================================================================
    Widget gridWidgets(ResidenceDetailsListController controller) {
    return Expanded(
      child: GridView.count(
        crossAxisSpacing: 25,
        mainAxisSpacing: 30,
        scrollDirection: Axis.vertical,
        childAspectRatio: (19 / 20),
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        children: List.generate(controller.residenceDetailList?.length??0, (index) {
          return InkWell(onTap: ()async{

            List<Placemark>placemarks = await placemarkFromCoordinates(
                                  double.parse(" ${controller.residenceDetailList?[index].locationLa}"), double.parse(" ${controller.residenceDetailList?[index].locationLo}"));
            String address='${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}';

            Get.to(()=>DetailedViewScreen(),arguments: [index,address]);
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
                      "${controller.residenceDetailList?[index].residenceName}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            "${controller.residenceDetailList?[index].bedRooms}BHK"),
                        SizedBox(
                            height: 15,
                            child: VerticalDivider(
                                color: Colors.black, thickness: 1)),
                        Text(
                            "${controller.residenceDetailList?[index].residenceType}")
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
// =========================================================================================================
// ======================================================================================
 


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
          Text("Fetching properties near by you...",style: TextStyle(color: Colors.brown[800],fontSize: 20),),
          // Spacer()
        ],
      ),
    );
}

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


  @override
  Widget build(BuildContext context) {
   

    ResidenceDetailsListController residenceDetailsListController =
          Get.put(ResidenceDetailsListController());
    residenceDetailsListController.fetchResidenceDetails();

    return Scaffold( 
      backgroundColor: Color(0xffedebf2),
      
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
                  } else if(controller.residenceDetailList?.length==0) {

                    return Text("Sorry we weren't able to find any properties in your location.");

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
