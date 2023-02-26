import 'package:flutter/material.dart';
class ColorsManager {
  static const Color whiteColor = Colors.white;
  static const Color greenColor = Color(0xff8ed53b);
  static const Color lightBlueColor = Color(0xff49e8ba);
  static const Color darkBlueColor = Color(0xff123456);
  static const Color greyLightColor = Colors.grey;
  static const Color yellowColor = Colors.yellowAccent;
  static const Color blackColor = Colors.black;
  static const Color redColor = Colors.red;
  static const Color transparentColor = Colors.transparent;
  static const Color lightGreyColor = Color.fromARGB(7, 14, 43, 255);
  static const Color backGroundColor = Color.fromARGB(191, 235, 236, 255);

}
Color handleText(String title){
  if(title=="Recommended"){
  return ColorsManager.yellowColor;
  }else if(title=="Fastest"){
    return ColorsManager.redColor;
  }else{
    return  ColorsManager.lightBlueColor;

  }

}
