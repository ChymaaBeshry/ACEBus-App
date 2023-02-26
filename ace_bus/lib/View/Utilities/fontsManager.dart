import 'package:ace_bus/View/Utilities/colorsManager.dart';
import 'package:flutter/material.dart';
class FontsManager{

 static TextStyle _getTextStyle(double size, FontWeight fontWeight , Color color)=>
      TextStyle(
        fontSize: size,
        fontWeight: fontWeight,
        color: color,
      );

 static TextStyle getTextStyleLight({ size= FontsSizeManager.size20 , color=ColorsManager.blackColor  })=>
      _getTextStyle(size, FontsWeightManager.fontWeightLight, color);

 static TextStyle getTextStyleRegular({ size= FontsSizeManager.size20 ,color=ColorsManager.blackColor   })=>
      _getTextStyle(size, FontsWeightManager.fontWeightRegular, color);

 static  TextStyle getTextStyleMedium({ size= FontsSizeManager.size20 ,color=ColorsManager.blackColor    })=>
      _getTextStyle(size, FontsWeightManager.fontWeightMedium, color);

 static  TextStyle getTextStyleSemiBold({ size= FontsSizeManager.size20 ,color=ColorsManager.blackColor   })=>
      _getTextStyle(size, FontsWeightManager.fontWeightSemiBold, color);

 static  TextStyle getTextStyleBold({ size= FontsSizeManager.size20 ,color=ColorsManager.blackColor    })=>
      _getTextStyle(size, FontsWeightManager.fontWeightBold, color);


}

class FontsWeightManager{
  static const FontWeight fontWeightLight= FontWeight.w300;
  static const FontWeight fontWeightRegular= FontWeight.w400;
  static const FontWeight fontWeightSemiBold= FontWeight.w600;
  static const FontWeight fontWeightBold= FontWeight.w700;
  static const FontWeight fontWeightMedium= FontWeight.w500;
}
class FontsSizeManager{
  static const double size15=15.0;
  static const double size20=20.0;
  static const double size30=30.0;
  static const double size40=40.0;
  static const double size50=50.0;
  static const double size60=60.0;
  static const double size70=70.0;
  static const double size80=80.0;
  static const double size90=90.0;
  static const double size100=100.0;
}