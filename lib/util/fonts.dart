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
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle piePercentageValueTextStyle = const TextStyle(
      color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold);

  //total stock container text
  static TextStyle totalStockContainerTextStyle = const TextStyle(
      color: StaticColors.totalStockContainerStockText,
      fontSize: 36,
      fontWeight: FontWeight.bold);

  //todays sterilization font
  static TextStyle todaysSterilizationText = const TextStyle(
      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold);

  static TextStyle todaysSterilizationCount =
      const TextStyle(fontSize: 10, color: Colors.black);

  //Timeline fonts
  static TextStyle timelineHead = const TextStyle(
      fontSize: 13.0, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle timelineBody = const TextStyle(color: Colors.white);
  static TextStyle timelineSubHead =
      const TextStyle(fontSize: 11.0, color: Colors.white);

  // saved used items card text
  static TextStyle savedUsedItems = TextStyle(
      backgroundColor: Colors.black.withAlpha(5),
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16);
}
