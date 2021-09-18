import 'package:VibeStay/controllers/enums/homeScreen.dart';
import 'package:VibeStay/models/QandAListModel.dart';
import 'package:VibeStay/models/userModel.dart';
import 'package:VibeStay/services/remoteServices.dart';
import 'package:get/get.dart';


class QandAListModelController extends GetxController{

  List<User> userList= [];
  List<QandAListModel>? qAndAList;
  CompletedFetching fetchingState=CompletedFetching.no;

    fetchResidenceDetails(String residence)async{
    List<QandAListModel> questions = await RemoteServices.getQandA(residence);
    if(questions != null){
      
      questions.removeWhere((qInstance) => qInstance.answer=="");
      print(questions.length);
      for (var item in questions) {
        print(item.question);
        print(item.answer);
        User userItem= await RemoteServices.getUser(item.user??"");
        this.userList.add(userItem);
        
        
      }

      this.qAndAList=questions;
      this.fetchingState=CompletedFetching.yes;
      update();

      

      // print(residenceDetails[1]);
    }
    // this.fetchingState=CompletedFetching.yes;
    update();
    // this.fetchingState=CompletedFetching.yes;
  }


}