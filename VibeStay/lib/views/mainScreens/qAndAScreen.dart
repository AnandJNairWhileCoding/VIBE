import 'package:VibeStay/controllers/enums/homeScreen.dart';
import 'package:VibeStay/controllers/modelControllers/qAndAListmodelController.dart';
import 'package:VibeStay/services/remoteServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QAndAScreen extends StatelessWidget {
  const QAndAScreen({Key? key}) : super(key: key);
  

  Widget displayComments() {
    QandAListModelController qAndAController = Get.find();

    return ListView(
      children: List.generate(qAndAController.qAndAList?.length ?? 0, (index) {
        return Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(
                                "${qAndAController.userList[index].photoUrl}")),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        Text("${qAndAController.userList[index].name}")
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Text(
                          "${qAndAController.qAndAList?[index].question}",
                          style: TextStyle(fontSize: 16)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orangeAccent),
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${qAndAController.qAndAList?[index].answer}",
                    style: TextStyle(fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                )
              ],
            )
          ],
        );
      }),
    );
  }

  Widget displayFetching() {
    return Center(
      child: Column(
        children: [
          Spacer(),
          CircularProgressIndicator(),
          SizedBox(
            height: 7,
          ),
          Text("Fetching Questions please wait."),
          Spacer()
        ],
      ),
    );
  }

  Widget displayNoComments() {
    return Text("Be the first to ask a question");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController=TextEditingController();
    QandAListModelController qAndAController = Get.find();


    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Questions"),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  GetBuilder<QandAListModelController>(builder: (controller) {
                if (controller.fetchingState == CompletedFetching.no) {
                  return displayFetching();
                } else {
                  if (controller.qAndAList?.length == 0) {
                    return displayNoComments();
                  } else {
                    return displayComments();
                  }
                }
              }),
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
                      hintText: "Ask a question",
                      border: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(
                              color: Colors.greenAccent, width: 10.0)),
                    ),
                  ),
                ),
                IconButton(
                  
                  onPressed: () async{
                    
                  
                var posted=await RemoteServices.postQuestion(Get.arguments, textController.text);
                if(posted){
                   Get.snackbar("Done", "Question Posted",
        // icon: Icon(Icons.warning, color: Colors.orange),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.white,
        isDismissible: true,
        animationDuration: Duration(seconds: 1));
                }


                  }, icon: Icon(Icons.send))
              ],
            )
          ],
        ),
      ),
    );
  }
}
