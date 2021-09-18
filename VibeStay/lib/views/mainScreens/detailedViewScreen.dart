import 'package:VibeStay/controllers/detailedViewScreenController.dart';
import 'package:VibeStay/controllers/modelControllers/qAndAListmodelController.dart';
import 'package:VibeStay/controllers/modelControllers/residenceDetailsListControllers.dart';
import 'package:VibeStay/models/owner.dart';
import 'package:VibeStay/services/remoteServices.dart';
import 'package:VibeStay/views/mainScreens/qAndAScreen.dart';
// import 'package:VibeStay/services/remoteServices.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DetailedViewScreen extends StatelessWidget {
  // const DetailedViewScreen({ Key? key }) : super(key: key);
  final CarouselController carouselController = CarouselController();
  final ResidenceDetailsListController residenceController = Get.find();

  Future<String> getAddress(int index) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(
            " ${residenceController.residenceDetailList?[index].locationLa}"),
        double.parse(
            " ${residenceController.residenceDetailList?[index].locationLo}"));
    return '${placemarks.first.subLocality}  ${placemarks.first.locality} ${placemarks.first.subAdministrativeArea} ${placemarks.first.postalCode}';
  }

  //RETURNS THE LIST OF IMAGE-URLS
  getImageUrl(int index) {
    //TO GET THE LIST OF IMAGES FROM THE DEPENDENCIES
    List imageUrl = [];
    for (var item in residenceController.residenceImages[index]) {
      // imageController.residenceDetailList[0].
      imageUrl.add(item.image);
    }
    return imageUrl;
  }

//TO BUILD THE SLIDE
  buildSlide(String imageUrl) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: Colors.white),
          boxShadow: [
            //background color of box
            BoxShadow(
              color: Colors.black38,
              blurRadius: 4.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: Offset(
                4.0, // Move to right 10  horizontally
                4.0, // Move to bottom 10 Vertically
              ),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(imageUrl), fit: BoxFit.contain)),
    );
  }

  Widget buildRowWidget(String black, String orange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(black,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(orange,
                style: TextStyle(
                  color: Colors.deepOrange,
                )),
          )
        ],
      ),
    );
  }

  onPressOfReport(int index) {
    Get.bottomSheet(Container(
      height: 400,
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await RemoteServices.postReport(
                    "Spam",
                    residenceController
                            .residenceDetailList?[index].residenceId ??
                        "");
                Get.back();
                Get.snackbar("Reported", "", icon: Icon(Icons.check));
              },
              child: Text("Spam")),
          ElevatedButton(onPressed: () async {
                await RemoteServices.postReport(
                    "Adult Content",
                    residenceController
                            .residenceDetailList?[index].residenceId ??
                        "");
                Get.back();

                Get.snackbar("Reported", "", icon: Icon(Icons.check));
              }, child: Text("Adult Content")),
          ElevatedButton(onPressed: () async {
                await RemoteServices.postReport(
                    "Other",
                    residenceController
                            .residenceDetailList?[index].residenceId ??
                        "");
                Get.back();

                Get.snackbar("Reported", "", icon: Icon(Icons.check));
              }, child: Text("Other"))
        ],
      ),
    ));
  }



  onPressOfCall(int index)async{
   Owner owner=await RemoteServices.getOwner(residenceController.residenceDetailList?[index].owner??"");
   print(owner.phoneNumber);
   bool? res = await FlutterPhoneDirectCaller.callNumber(owner.phoneNumber??"+917760690830");

  }
//DELETE BUTTON ACTION

  @override
  Widget build(BuildContext context) {
    int index = Get.arguments[0];

    List imageUrl = getImageUrl(index);
    ResidenceDetailsListController imageController = Get.find();
    int noOfImages = imageController.residenceImages[index].length;
    DetailedViewScreenController thisScreenController =
        Get.put(DetailedViewScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
            " ${residenceController.residenceDetailList?[index].residenceName}"),
        actions: [
          IconButton(
              onPressed: (){
                onPressOfReport(index);
              },
              icon: Icon(
                Icons.report,
                color: Colors.red,
              )),
          IconButton(
              onPressed: (){
                onPressOfCall(index);
              },
              icon: Icon(
                Icons.call,
                color: Colors.green,
              ))
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 13,
          ),
          CarouselSlider.builder(
              carouselController: carouselController,
              itemCount: imageUrl.length,
              itemBuilder: (v, index, vv) {
                return buildSlide(imageUrl[index]);
              },
              options: CarouselOptions(
                onPageChanged: (count, c) {
                  thisScreenController.setActiveSlide(count);
                },
                initialPage: thisScreenController.activeSlide,
                enableInfiniteScroll: false,
                autoPlay: true,
                height: 300,
                aspectRatio: 16 / 9,
                enlargeCenterPage: true,
              )),
// TRACKER
          Center(
            child:
                GetBuilder<DetailedViewScreenController>(builder: (controller) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(noOfImages, (active) {
                  return InkWell(
                    onTap: () {
                      print(active);
                      carouselController.animateToPage(active);
                    },
                    child: Container(
                      height: 10,
                      width: 10,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: active == controller.activeSlide
                            ? Colors.black54
                            : Colors.orange,
                      ),
                    ),
                  );
                }),
              );
            }),
          ),

          //BEDROOM WASHROOM PRICE
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.bed,
                    size: 35,
                    color: Colors.orange,
                  ),
                  Text(
                    " ${residenceController.residenceDetailList?[index].bedRooms}",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.bathtub_rounded,
                    size: 30,
                    color: Colors.orange,
                  ),
                  Text(
                    " ${residenceController.residenceDetailList?[index].washRooms}",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text("₹",
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Text(
                    " ${residenceController.residenceDetailList?[index].cost}",
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                ],
              ),
            ),
          ),

// WRITTEN DETAILS LIKE RESIDENCE-NAME CARPET-AREA,PARKING,LOCATION

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildRowWidget("Residence Name:",
                  " ${residenceController.residenceDetailList?[index].residenceName}"),
              buildRowWidget("Residence Type:",
                  " ${residenceController.residenceDetailList?[index].residenceType}"),
              buildRowWidget("Carpet Area:",
                  " ${residenceController.residenceDetailList?[index].carpetArea}"),
              buildRowWidget("Vehicle Parking:",
                  " ${residenceController.residenceDetailList?[index].parking ?? false ? "Available" : "Not Available"}"),
              buildRowWidget("Address:", Get.arguments[1]),
            ],
          ),

          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.20),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     child: Row(children: [ic],),
          //     style: ElevatedButton.styleFrom(primary: Colors.green),
          //   ),
          // ),
          //GOOGLE MAP
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.10, vertical: 20),
            padding: EdgeInsets.all(1),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.brown[100] ?? Colors.brown, width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GoogleMap(
                markers: {
                  Marker(
                    markerId: MarkerId("marker"),
                    position: LatLng(
                        double.parse(residenceController
                                .residenceDetailList?[index].locationLa ??
                            ""),
                        double.parse(residenceController
                                .residenceDetailList?[index].locationLo ??
                            "")),
                  )
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse(residenceController
                                .residenceDetailList?[index].locationLa ??
                            ""),
                        double.parse(residenceController
                                .residenceDetailList?[index].locationLo ??
                            "")),
                    zoom: 16)),
          ),

          //QNA BUTTON

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 8),
            child: TextButton(
              onPressed: () async {
                // RemoteServices.postQuestion("${residenceController.residenceDetailList?[index].residenceId}", "posting a question");
                // var test =await RemoteServices.getQandA("${residenceController.residenceDetailList?[index].residenceId}");

                // print(test);

                QandAListModelController q =
                    Get.put(QandAListModelController());
                q.fetchResidenceDetails(
                    "${residenceController.residenceDetailList?[index].residenceId}");
                Get.to(() => QAndAScreen(),
                    arguments:
                        "${residenceController.residenceDetailList?[index].residenceId}");
              },
              child: Text("Customer Questions"),
              style: TextButton.styleFrom(
                  primary: Colors.black87,
                  backgroundColor: Colors.orangeAccent[200],
                  textStyle: TextStyle(fontSize: 21)),
            ),
          ),
        ],
      ),
    );
  }
}
