
import 'package:VibeStay/controllers/enums/locationFetchingState.dart';
import 'package:VibeStay/controllers/homeScreenController.dart';
import 'package:VibeStay/services/fetchLocation.dart';
import 'package:get/get.dart';
 

 class UpdateLocationController extends GetxController{

    double? lattitude;
    double? longitude;
    
    
    initializeLatLong(LocationFetchingController locationFetchingController)async{
      var coordinates = await fetchLocation();
      print(coordinates.latitude);
      print(coordinates.longitude);
      this.lattitude=coordinates.latitude;
      this.longitude=coordinates.longitude;
      update();

      // this.fetchingState=LocationFetchingState.completedFetching;
      locationFetchingController.setFetchingState(LocationFetchingState.completedFetching);
      LocationController locationController=Get.find();
      // TO CHANGE THE CHIP WIDGET ADDRESS TO CURRENT ADDRESS
      locationController.setLocationWithCoordinates(coordinates.latitude,coordinates.longitude);
      
    }

    setLatLon(double lattitude,double longitude){
      this.lattitude=lattitude;
      this.longitude=longitude;
      update();

    }

 }



  class LocationFetchingController extends GetxController{

   
    LocationFetchingState fetchingState=LocationFetchingState.fetching;
    
    
      
    

    setFetchingState(LocationFetchingState fetchingState){
      this.fetchingState=fetchingState;
      update();

    }

 }