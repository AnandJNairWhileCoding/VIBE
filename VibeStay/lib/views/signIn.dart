import 'package:VibeStay/controllers/localDB/localDataBase.dart';
import 'package:VibeStay/services/remoteServices.dart';
import 'package:VibeStay/views/mainScreens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';//here for routing to next screen

class SignIn extends StatelessWidget {
  SignIn({ Key? key }) : super(key: key);
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.orange, Colors.white],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(55))),
                height: MediaQuery.of(context).size.height / 100 * 70,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "VIBE",
                      style: TextStyle(
                        color: Colors.brown[500],
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Stay ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                          // Text(
                          //   "it",
                          //   style: TextStyle(
                          //       color: Colors.orange,
                          //       fontSize: 60,
                          //       fontWeight: FontWeight.bold),
                          // )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 90),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black38,
                                  spreadRadius: 3,
                                  offset: Offset(-1, 10)),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.home_sharp,
                            size: 70,
                            color: Colors.orange[700],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: InkWell(
                  onTap: () async{
                   var userDetails= await _googleSignIn.signIn();
                   //saving the sign-in details in shared preferences
                  //  setOwnerDetails(userDetails.email, userDetails.displayName, userDetails.photoUrl); 
                  var email=userDetails?.email;
                   setUserDetails(email??"", userDetails?.displayName, userDetails?.photoUrl);
                   print("${userDetails?.photoUrl}");
                   await RemoteServices.createUser();

                   setIsSignedin();// setting signed-in in shared preferences
                  
                   

                   
                  //  print(b);
                  //  var c= await _googleSignIn.signOut();
                  //  print(c);
                   Get.off(()=>Home(),
          fullscreenDialog: true,
          transition: Transition.fadeIn,
          arguments: userDetails?.displayName);

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.black26, width: 5),
                    ),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Row(
                      children: [
                        Text(
                          "sign in with google  ",
                          style: TextStyle(color: Colors.orange, fontSize: 25),
                        ),
                        Text(
                          "G",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}




