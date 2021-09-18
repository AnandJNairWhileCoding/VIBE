import 'package:VibeRentIt/controllers/localDB/localData.dart'; //to setIsSignedIn() and setUserDetails
import 'package:VibeRentIt/views/otpScreen.dart';//next screen widget
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';//here for routing to next screen


// class SignIn extends StatelessWidget {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
  // GoogleSignInAccount _userObj;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//                 decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [Colors.orange, Colors.white],
//                         begin: Alignment.bottomLeft,
//                         end: Alignment.topRight),
//                     borderRadius:
//                         BorderRadius.only(bottomLeft: Radius.circular(55))),
//                 height: MediaQuery.of(context).size.height / 100 * 70,
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       "VIBE",
//                       style: TextStyle(
//                         color: Colors.brown[500],
//                         fontSize: 100,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Rent",
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 60,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             "it",
//                             style: TextStyle(
//                                 color: Colors.orange,
//                                 fontSize: 60,
//                                 fontWeight: FontWeight.bold),
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 90),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             boxShadow: [
//                               BoxShadow(
//                                   blurRadius: 5,
//                                   color: Colors.black38,
//                                   spreadRadius: 3,
//                                   offset: Offset(-1, 10)),
//                             ]),
//                         child: Padding(
//                           padding: const EdgeInsets.all(5.0),
//                           child: Icon(
//                             Icons.home_sharp,
//                             size: 70,
//                             color: Colors.orange[700],
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 70),
//               child: InkWell(
//                   onTap: () async{
//                    var userDetails= await _googleSignIn.signIn();
//                    await setIsSignedin();
//                    await setUserDetails(userDetails.email, userDetails.displayName, userDetails.photoUrl);
                   
//                   //  print(b);
//                   //  var c= await _googleSignIn.signOut();
//                   //  print(c);
//                    Get.off(()=>OtpScreen(),
//           fullscreenDialog: true,
//           transition: Transition.fadeIn,
//           arguments: userDetails.displayName);

//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                       border: Border.all(color: Colors.black26, width: 5),
//                     ),
//                     width: MediaQuery.of(context).size.width / 1.5,
//                     child: Row(
//                       children: [
//                         Text(
//                           "sign in with google  ",
//                           style: TextStyle(color: Colors.orange, fontSize: 25),
//                         ),
//                         Text(
//                           "G",
//                           style: TextStyle(
//                               color: Colors.orange,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     ),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Text(
//                 "VIBE",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 100,
//                     fontWeight: FontWeight.bold,
//                     ),
//               ),
//               Center(
//                 child: Row(mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Rent",
//                       style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 60,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       "it",
//                       style: TextStyle(
//                           color: Colors.orange[400],
//                           fontSize: 60,
//                           fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               )









Widget si(BuildContext context){
  final GoogleSignIn _googleSignIn = GoogleSignIn();

 return Center(
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
                            "Rent",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "it",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 60,
                                fontWeight: FontWeight.bold),
                          )
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
                   await setIsSignedin();// setting signed-in in shared preferences
                   //saving the sign-in details in shared preferences
                   await setOwnerDetails(userDetails.email, userDetails.displayName, userDetails.photoUrl); 
                  
                   

                   
                  //  print(b);
                  //  var c= await _googleSignIn.signOut();
                  //  print(c);
                   Get.off(()=>OtpScreen(),
          fullscreenDialog: true,
          transition: Transition.fadeIn,
          arguments: userDetails.displayName);

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
      );
}