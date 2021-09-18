// import 'package:VibeRentIt/models/userModel.dart';
import 'package:VibeRentIt/controllers/enums/homeScreen.dart';
import 'package:VibeRentIt/models/ResidenceDetailsListModel.dart';
import 'package:VibeRentIt/models/residenceImagesModel.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
import 'package:get/get.dart';

class ResidenceDetailsListController extends GetxController {
  List<ResidenceDetailsListModel> residenceDetailList;
  List<List<ResidenceImageModel>>residenceImages=[];
  CompletedFetching fetchingState=CompletedFetching.no;


  fetchResidenceDetails()async{
    List<ResidenceDetailsListModel> residenceDetails = await RemoteServices.getResidenceDetails();
    if(residenceDetails != null){
      this.residenceDetailList= residenceDetails;
      for (var item in residenceDetails) {
        print(item);
        List<ResidenceImageModel> result=await this.fetchResidenceImages(item.residenceId);
        print("the result is");
        print(result);
        this.residenceImages.add(result);
        }
      

      // print(residenceDetails[1]);
    }
    this.fetchingState=CompletedFetching.yes;
    update();
    // this.fetchingState=CompletedFetching.yes;
  }


  fetchResidenceImages(String residenceId)async{
    List<ResidenceImageModel> residenceImageList = await RemoteServices.getResidenceImages(residenceId);
    if(residenceImageList != null){
      // this.residenceDetailList= residenceDetails;
      print("retuuuuuuuuuuuuuuuuuuu");
      return residenceImageList;
      }
    
  }

   deleteResidence(int index){
     print(index);
    this.residenceDetailList.removeAt(index);
      update();
  }
  
}