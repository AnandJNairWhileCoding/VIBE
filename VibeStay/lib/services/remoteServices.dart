// import 'dart:convert';
// import 'dart:io';
// import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeStay/controllers/localDB/localDataBase.dart';
import 'package:VibeStay/models/QandAListModel.dart';
import 'package:VibeStay/models/ResidenceDetailsListModel.dart';
import 'package:VibeStay/models/owner.dart';
import 'package:VibeStay/models/userModel.dart';
// import 'package:VibeRentIt/models/residenceIdModel.dart';
import 'package:VibeStay/models/residenceImagesModel.dart';
import 'package:VibeStay/models/userModel.dart';
import 'package:http/http.dart';

class RemoteServices {
  static var client = Client();
  static var url = 'http://10.0.2.2:8000/';
  static var userDetail = getUserDetails();
  static var locationDetail = getLocationDetails();

  static Future createUser() async {
    var ownerData = {
      "eMail": "${userDetail["gmail"]}",
      "name": "${userDetail["name"]}",
      "photoUrl": "${userDetail["image"]}",
    };

    var response = await client.post(
      Uri.parse("${url}createUser1/"),
      body: ownerData,
    );

    print("${userDetail["image"]}");

    print("inside post method");

    if (response.statusCode == 200) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

//TO UPLOAD THE RESIDENTIAL DETAILS

//TO UPLOAD THE RESIDENCE IMAGES

  static Future<List<ResidenceDetailsListModel>> getResidenceDetails() async {
    print(userDetail["gmail"]);
    var response = await client.get(Uri.parse(
        "${url}listFilteredResidentialDetails/?la=${locationDetail["lattitude"]}&lo=${locationDetail["longitude"]}"));
    if (response.statusCode == 200) {
      var jsonString = response.body;

      print(response.body);
      return residenceDetailsListModelFromJson(jsonString);
    } else {
      throw FormatException("error occured ${response.statusCode}");
    }
  }

  static Future<List<ResidenceImageModel>?> getResidenceImages(
      String? residenceId) async {
    var response =
        await client.get(Uri.parse("${url}listImage/?residence=$residenceId")
            // headers: {
            //   "residence":residenceId,
            // },
            );
    var body = response.body;
    print(body);

    try {
      if (response.statusCode == 200) {
        var jsonString = response.body;

        print(response.body);
        return residenceImageModelFromJson(jsonString);
      } else {
        throw FormatException("error occured ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  static Future 
  getQandA(String residence) async {
    var response = await client.get(
      Uri.parse("${url}listQandA/?residence=$residence"),
    );

    print("inside QNA get method");

    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;

      return qandAListModelFromJson(jsonString);
    } else {
      return false;
    }
  }

  static Future postQuestion(String residence, String question) async {
    var questionbody = {
      "residence": residence,
      "user": "${userDetail["gmail"]}",
      "question": question,
    };

    var response = await client.post(
      Uri.parse("${url}postQandA/"),
      body: questionbody,
    );

    print("inside post method");

    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

    static Future getUser(String eMail) async {
    
    var response = await client.get(
      Uri.parse("${url}retriveUser/$eMail"),
      
    );

    print("inside user get method");

    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;

      return userFromJson(jsonString);
      
    } else {
      return false;
    }
  }

      static Future getOwner(String eMail) async {
    
    var response = await client.get(
      Uri.parse("${url}retriveOwner/$eMail"),
      
    );

    print("inside user get method");

    if (response.statusCode == 200) {
      print(response.body);
      var jsonString = response.body;

      return ownerFromJson(jsonString);
      
    } else {
      return false;
    }
  }


    static Future postReport(String report,String residence) async {
    var reportbody = {
      "residenceId": residence,
      "user": "${userDetail["gmail"]}",
      "report": report,
    };

    var response = await client.post(
      Uri.parse("${url}postReport/"),
      body: reportbody,
    );

    print("inside post method");

    if (response.statusCode == 201) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }


}
