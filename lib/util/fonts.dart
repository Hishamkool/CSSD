import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class FontStyles {
  //Textsizes
  static double appBarTitleSize = 25.0;

  //TextStyles
  static TextStyle appBarTitleStyle = TextStyle(
    color: StaticColors.textwhiteLight,
    fontSize: appBarTitleSize,
  );

  static TextStyle bodyPieTitleStyle = const TextStyle(
      color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold);

  static TextStyle piePercentageValueTextStyle = const TextStyle(
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold);

  //total stock container text
  static TextStyle totalStockContainerTextStyle = const TextStyle(
      color: StaticColors.totalStockContainerStockText,
      fontSize: 36,
      fontWeight: FontWeight.bold);
}
