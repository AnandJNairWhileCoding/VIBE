import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  // const ProfilePage({Key key}) : super(key: key);
final otpcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId;
  

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 5),
            Center(
                child: CircleAvatar(
              backgroundImage: NetworkImage(Get.arguments.photoUrl),
              radius: 50,
            )),
            TextField(
              controller: otpcontroller,
            ),
            ElevatedButton(
              child: Text("otp"),
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: otpcontroller.text);
                try {
                  final authCredential =
                      await _auth.signInWithCredential(phoneAuthCredential);

                  if (authCredential.user != null) {
                    print("working");
                  }
                } on FirebaseAuthException catch (e) {
                  print(e);
                  print("nshdgvfdsvjhgdsjvjhdsjgvjhdsvjfgjdsgfjgdjsvgfdsjfjhs");
                  print(otpcontroller.text);
                  print("$verificationId kjgghhgdhgfhghgfhf");
                }
              },
            ),
            ElevatedButton(
              child: Text("verify"),
              onPressed: () async {
                await _auth.verifyPhoneNumber(
                    phoneNumber: "+917760690830",
                    verificationCompleted: (value) {
                      print(value);
                      print("woooooooooooooorrrrrrkkkkkkkkkkrrrkkkk");
                    },
                    verificationFailed: (value) {
                      print(value.message);
                    },
                    codeSent: (verificationId, resendingToken) async {
                      this.verificationId = verificationId;
                    },
                    codeAutoRetrievalTimeout: (value) {
                      this.verificationId = verificationId;
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}






