import 'package:VibeRentIt/controllers/detailedViewScreenController.dart';
import 'package:VibeRentIt/controllers/modelControllers/QandAListModelController.dart';
import 'package:VibeRentIt/controllers/modelControllers/ResidenceDetailsListController.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailedViewScreen extends StatelessWidget {
  // const DetailedViewScreen({ Key? key }) : super(key: key);
  final CarouselController carouselController = CarouselController();
  final ResidenceDetailsListController residenceController = Get.find();

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
          Text(orange,
              style: TextStyle(
                color: Colors.deepOrange,
              ))
        ],
      ),
    );
  }

//DELETE BUTTON ACTION
  onPressOfDelete(int index) {
    Get.defaultDialog(
        title: "Warning!",
        middleText: "Delete this Add?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () async {
          print("the value of index is $index");
          try {
            if (await RemoteServices.deleteResidenceDetails(
                residenceController.residenceDetailList[index].residenceId)) {
              residenceController.deleteResidence(index);
              Get.back();
              Get.back();
              Get.snackbar("Deleted", "");
            }
          } catch (e) {
            Get.snackbar("$e", "");
          }
        });
  }

  Widget questionWidget(QandAListModelController questionController) {
    return Column(
      children: List.generate(questionController.qAndAList.length, (index) {
        TextEditingController textController = TextEditingController();
        return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
              width: Get.width,

              // color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 3),
                child: Text("${questionController.userList[index].name}"),
              )),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, bottom: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "${questionController.qAndAList[index].question}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),

                  // SizedBox(height: 1,),
                ],
              ),
              Spacer()
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    counter: Offstage(),
                    hintText: "Answer this question",
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        borderSide:
                            BorderSide(color: Colors.greenAccent, width: 10.0)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    print('${textController.text}');

                    await RemoteServices.postAnswer(
                        questionController.qAndAList[index].id,
                        questionController.qAndAList[index].residence,
                        questionController.qAndAList[index].user,
                        questionController.qAndAList[index].question,
                        textController.text);
                    textController.text = "";
                    questionController.deleteQuestionFromList(index);
                  },
                  icon: Icon(Icons.send))

//inner columnnnnnnnnnnnnn
            ],
          )
        ]);
      }),
    );
  }

  Widget noPostWidget() {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.only(top: 25,bottom: 10),
          child: Icon(
            Icons.comment,
            size: 50,
            color: Colors.grey,
          ),
        ),
        Text(
          "There are no queries asked for this ad",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey,
          fontSize: 19),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = Get.arguments;
    List imageUrl = getImageUrl(index);
    ResidenceDetailsListController imageController = Get.find();
    int noOfImages = imageController.residenceImages[index].length;
    DetailedViewScreenController thisScreenController =
        Get.put(DetailedViewScreenController());
    QandAListModelController questions = Get.put(QandAListModelController());
    questions
        .fetchQandA(residenceController.residenceDetailList[index].residenceId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${residenceController.residenceDetailList[index].residenceName}"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              print(index);
              onPressOfDelete(index);
            },
            icon: Icon(Icons.delete),
            color: Colors.deepOrange[400],
          )
        ],
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
                    "${residenceController.residenceDetailList[index].bedRooms}",
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
                    "${residenceController.residenceDetailList[index].washRooms}",
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
                    "60000",
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
                  " ${residenceController.residenceDetailList[index].residenceName}"),
              buildRowWidget("Residence Type:",
                  " ${residenceController.residenceDetailList[index].residenceType}"),
              buildRowWidget("Carpet Area:",
                  " ${residenceController.residenceDetailList[index].carpetArea}"),
              buildRowWidget("Vehicle Parking:",
                  " ${residenceController.residenceDetailList[index].parking ? "Available" : "Not Available"}"),
            ],
          ),
          //GOOGLE MAP
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * 0.10, vertical: 20),
            padding: EdgeInsets.all(1),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown[100], width: 5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GoogleMap(
                markers: {
                  Marker(
                    markerId: MarkerId("marker"),
                    position: LatLng(
                        double.parse(residenceController
                            .residenceDetailList[index].locationLa),
                        double.parse(residenceController
                            .residenceDetailList[index].locationLo)),
                  )
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse(residenceController
                            .residenceDetailList[index].locationLa),
                        double.parse(residenceController
                            .residenceDetailList[index].locationLo)),
                    zoom: 16)),
          ),
          SizedBox(
            height: 10,
          ),

          Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    " Answer Customer's Questions: ",
                    style: TextStyle(fontSize: 24, color: Colors.brown[800]),
                  ))),

          GetBuilder<QandAListModelController>(builder: (questionController) {
            if (questionController.qAndAList.length == 0) {
              return noPostWidget();
            } else {
              return questionWidget(questionController);
            }
          })

          //         SizedBox(height: 10,),
          //         Text("    Rathnam"),

          // Row(
          //   children: [
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [

          //         Container(
          //           margin: EdgeInsets.only(left: 10,bottom: 20),
          //           padding: EdgeInsets.all(10),
          //           decoration: BoxDecoration(color: Colors.orange[300],
          //           borderRadius: BorderRadius.circular(10)
          //           ),
          //           child: Text("is the price negotiable?",style: TextStyle(fontSize: 15),),
          //         ),

          //         // SizedBox(height: 1,),
          //       ],
          //     ),
          //     Spacer()
          //   ],
          // ),

          //             Row(
          //     children: [
          //       SizedBox(
          //         width: 5,
          //       ),
          //       Expanded(
          //         child: TextField(
          //           // controller: textController,
          //           decoration: InputDecoration(
          //             counter: Offstage(),
          //             hintText: "Answer this question",
          //             border: OutlineInputBorder(
          //                 // borderSide: BorderSide.none,
          //                 borderRadius: BorderRadius.all(Radius.circular(15.0)),
          //                 borderSide: BorderSide(
          //                     color: Colors.greenAccent, width: 10.0)),
          //           ),
          //         ),
          //       ),
          //       IconButton(

          //         onPressed: () async{

          //         }, icon: Icon(Icons.send))
          //     ],
          //   ),
        ],
      ),
    );
  }
}
