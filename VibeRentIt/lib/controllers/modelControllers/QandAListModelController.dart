import 'package:VibeRentIt/controllers/enums/homeScreen.dart';
import 'package:VibeRentIt/models/QandAListModel.dart';
import 'package:VibeRentIt/models/userModel.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:get/get.dart';


class QandAListModelController extends GetxController{

  List<User> userList= [];
  List<QandAListModel> qAndAList;
  CompletedFetching fetchingState=CompletedFetching.no;

    fetchQandA(String residence)async{
    List<QandAListModel> questions = await RemoteServices.getQandA(residence);
    if(questions != null){
      
      questions.removeWhere((qInstance) => qInstance.answer!="");
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



  deleteQuestionFromList(int index){
        this.qAndAList.removeAt(index);
        this.userList.removeAt(index);
        update();
  }


}