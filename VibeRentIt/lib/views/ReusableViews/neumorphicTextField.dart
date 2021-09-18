import 'package:flutter/material.dart';

Widget neumorphicTextField(String hint, TextEditingController controller,
    TextInputType keyboardType, int maxLength) {
  return Container(
    decoration: BoxDecoration(
        color: Color(0xffedebf2),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 14.0,
              offset: Offset(10.0, 10.0),
              spreadRadius: 1),
          BoxShadow(
              color: Colors.white,
              blurRadius: 13.0,
              spreadRadius: 1,
              offset: Offset(-10.0, -10.0))
        ]),
    child: TextField(
        maxLength: maxLength,
        
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(

          counter: Offstage(),
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ))),
  );
}
