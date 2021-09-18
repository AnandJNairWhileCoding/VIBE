// import 'package:VibeRentIt/models/userModel.dart';
import 'package:VibeRentIt/services/remoteServices.dart';
// import 'package:get/get.dart';

class OwnerModelController {
  var userList;

  void fetchOwner()async{
    var user = await RemoteServices.putUser();
    if(user != null){
      this.userList= user;
      print(user.id);
    }
  }
  
}