 import 'package:flutter/material.dart';
 import 'package:flutter_svg/flutter_svg.dart';
 
 Widget neumorphicBanner(String image){
 return Center(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    // padding: EdgeInsets.all(10),
                    
                    // child: Container(
                    //     height: 220,
                    //     width: 230,
                    //     decoration: BoxDecoration(
                    //         color: Colors.black12, shape: BoxShape.circle)),
                    child: SvgPicture.asset(image,fit: BoxFit.contain,),
                    height: 220,
                    width: 230,
                    decoration: BoxDecoration(
                      color: Color(0xffedebf2),
                        // border: Border.all(color: Colors.orange),
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100),
                        
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8.0,
                              spreadRadius: 1,
                              offset: Offset(4.0, 4.0)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 10.0,
                              spreadRadius: 2,
                              offset: Offset(-4.0, -4.0))
                        ]
                        ),
                  ),
                );}