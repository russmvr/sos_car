import 'dart:ui';

import 'package:flutter/material.dart';

class MyImagesSize{

  static widthImageCar12(BuildContext context) =>
      MediaQuery.of(context).size.width*0.13;
  static heightImageCar12(BuildContext context) =>
      widthImageCar12(context)*0.923;

  static widthImageCar34(BuildContext context) =>
      MediaQuery.of(context).size.width*0.2213;
  static heightImageCar34(BuildContext context) =>
      widthImageCar34(context)*0.518;

  static widthImageDoc134(BuildContext context) =>
      MediaQuery.of(context).size.width*0.1658;
  static heightImageDoc134(BuildContext context) =>
      widthImageDoc134(context)*1.302;

  static widthImageDoc2(BuildContext context) =>
      MediaQuery.of(context).size.width*0.2249;
  static heightImageDoc2(BuildContext context) =>
      widthImageDoc2(context)*0.628;


  static widthFrame(BuildContext context) =>
      MediaQuery.of(context).size.width*0.32;
  static heightFrame(BuildContext context) =>
      MediaQuery.of(context).size.width*0.32;
}

class MyParams{
  static const double rounding = 15.0;

  static fieldPadding(BuildContext context) =>
      MediaQuery.of(context).size.width*0.096;
  static textLeftPadding(BuildContext context) =>
      MediaQuery.of(context).size.width*0.106;


  static var textBold = FontWeight.w700;
  static var textNormal = FontWeight.w400;





}

class MyColors {
  /// App style colors.
  static const grayTextField = Color(0xFFF7F8F9);
  static const grayBorder = Color(0xFFD5DDE0);
  static const blue = Color(0xFF1152FD);
  static const black = Color(0xFF3E4958);
  static const grayText = Color(0xFF97ADB6);
  static const grayText2 = Color(0xFF4B545A);
  static const grayCircleAvatar = Color(0xFFC4C4C4);
  static const frameColor = Color(0xFFD5DDE0);
  static const grayTextField2Color = Color(0xFFD1D1D1);
  static const white = Colors.white;
  static const redText = Color(0xFFF16060);

  /// Shadow color.
  static const shadow = Color.fromRGBO(0, 0, 0, 0.1);
}
