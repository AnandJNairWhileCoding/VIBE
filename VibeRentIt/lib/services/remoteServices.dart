import 'dart:convert';
import 'dart:io';
import 'package:VibeRentIt/controllers/addingScreenController.dart';
import 'package:VibeRentIt/controllers/localDB/localData.dart';
import 'package:VibeRentIt/models/QandAListModel.dart';
import 'package:VibeRentIt/models/ResidenceDetailsListModel.dart';
import 'package:VibeRentIt/models/ownerModel.dart';
import 'package:VibeRentIt/models/residenceIdModel.dart';
import 'package:VibeRentIt/models/residenceImagesModel.dart';
import 'package:VibeRentIt/models/userModel.dart';
import 'package:http/http.dart';

class RemoteServices {
  static var client = Client();
  static var url = 'http://10.0.2.2:8000/';
  static var userDetail = getUserDetails();

  // static Future fetchUser() async {
  //   var response = await client.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     print(response.body);
  //     return welcomeFromJson(jsonString);
  //   }
  // }

  static Future putUser() async {
    var responce = await client.put(Uri.parse(url), body: {
      "id": "1",
      "u_id": "18V9SB7006",
      "name": "anandiii",
      "about": "from flutter"
    });
    if (responce.statusCode == 200) {
      // var jsonString = responce.body;
      print(responce.body);
      print("working");
      // return welcomeFromJson(jsonString);
    }
  }

  static Future createOwner(Map userDetail) async {
    var ownerData = {
      "eMail": "${userDetail["gmail"]}",
      "name": "${userDetail["name"]}",
      "photoUrl": "${userDetail["image"]}",
      "phoneNumber": "${userDetail["phoneNumber"]}"
    };
    var response = await client.post(
      Uri.parse("${url}createUser/"),
      body: ownerData,
    );

    if (response.statusCode == 20) {
      print(response.body);
      return true;
    } else {
      return false;
    }
  }

//TO UPLOAD THE RESIDENTIAL DETAILS

  static Future uploadResidenceDetails(
      ResidenceDetails residenceDetails) async {
    //getting the user details from the shared preference
    var forEmail = getUserDetails();

    var residenceData = {
      "eMail": "${forEmail["gmail"]}",
      "residenceName": residenceDetails.name,
      "residenceType": residenceDetails.residenceType,
      "bedRooms": residenceDetails.bedRoom,
      "washRooms": residenceDetails.washRoom,
      "carpetArea": residenceDetails.carpetArea,
      "parking": residenceDetails.parking,
      "cost": residenceDetails.cost,
      "locationLA": residenceDetails.locationLA,
      "locationLO": residenceDetails.locationLO
    };
    var response = await client.post(
        Uri.parse("${url}uploadResidentialDetails/"),
        body: residenceData);

    if (response.statusCode == 201) {
      var jsonString = response.body;

      print(response.body);
      return residenceIdModelFromJson(jsonString);
    } else {
      throw FormatException("some error");
    }
  }

//TO UPLOAD THE RESIDENCE IMAGES

  static Future uploadImage(String imagePath, String residenceId) async {
    var response = await client.post(
      Uri.parse("${url}uploadImage/"),
      body: {
        "residenceId": residenceId,
        "image": base64Encode(File(imagePath).readAsBytesSync()),
      },
    );
    print("posted");

    if (response.statusCode == 201) {
      var jsonString = response.body;

      print(response.body);
      return true;
    } else {
      throw FormatException("some error");
    }
  }

  static Future<List> getResidenceDetails() async {
    print(userDetail["gmail"]);
    var response = await client.get(
      Uri.parse("${url}listResidentialDetails/?owner=${userDetail["gmail"]}"),
      // headers: {
      //   "owner":"${userDetail["gmail"]}" ,
      // },
    );
    if (response.statusCode == 200) {
      var jsonString = response.body;

      print(response.body);
      return residenceDetailsListModelFromJson(jsonString);
    } else {
      throw FormatException("error occured ${response.statusCode}");
    }
  }

  static Future<bool> deleteResidenceDetails(String residenceId) async {
    print(userDetail["gmail"]);
    var response = await client.delete(
      Uri.parse("${url}deleteResidence/$residenceId"),
      // headers: {
      //   "owner":"${userDetail["gmail"]}" ,
      // },
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      throw FormatException("error occured ${response.statusCode}");
    }
  }

  static Future<List> getResidenceImages(String residenceId) async {
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


  static Future getQandA(String residence) async {
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


    static Future postAnswer(int id,String residence,String user,String question,String answer) async {
    var questionbody = {
      "id":"$id",
      "residence":residence,
      "user":user,
      "question":question,
      "answer":answer
    };

    var response = await client.put(
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



}
