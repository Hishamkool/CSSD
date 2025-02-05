import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';

class GradientColors {
  static List<Color> splashGradient = const [
    Color.fromRGBO(30, 106, 159, 100),
    Color(0xff1e6a9f),
    Color(0xff6c9dc0),
  ];

  static List<Color> backgroundGradient = const [
    StaticColors.scaffoldBackgroundcolor, // Dark Blue
    Color(0xFFbbdefb), // Medium Blue
    Color(0xFFe3f2fd), // Light Blue
    Colors.white,
  ];

  static List<Color> blueGraient = const [
    Color(0xff091e3a),
    Color(0xff2f80ed),
    Color(0xff2d9ee0),
  ];

  static List<Color> greyGraient = const [
    Color(0xff536976),
    Color(0xff292e49),
  ];
}

class StaticColors {
  static Color transparentGlassContainer =
      const Color.fromRGBO(71, 225, 252, 0.32);
  //app background color
  static const scaffoldBackgroundcolor = Color(0xFF044B7F);

  static const blueLight = Color(0xFFDCDBFE);
  static const textwhiteLight = Color(0xFFFFFFFF);
  static const timelineBackkground = Color(0xFF351A5C);

  //Button colors
  static const cancelButton = Color(0xFFF75457);
  static const acceptButton = Color(0xFF00CC99);
  static const sendAsPackageButton = Color(0xFF168AAD);
  static const defaultButton = Color(0xFF044B7F);
  static const notificationAlertsNumber = Color(0xFFB3261E);

  //pie chart colors
  static const pieRequestCount =
      Color(0xFF0C9EDF); //use same color for totalstock linear progress
  static const pieSterilizationComplete =
      Color(0xFF3E3C8C); //use same color for totalstock linear progress
  static const pieSterilizationOnProgress = Color(0xFF7A61D3);

  //total stock colors
  static const totalStockContainerBackground =
      Color.fromRGBO(217, 217, 217, 0.02);
  static const totalStockContainerStockText = Color(0xFFFF9D00);

  //request container  colors
  static const requestContainerBackground = Color(0xFFFEF7FF);
  static const requestContainerNumberBackground = Color(0xFFFF4906);
  static const pickupRequestContainerBackground = Color(0xFFFEF7FF);

  // doctor image background
  static const doctorImageBackgroundColor = Color(0xff22549B);

  //container colors
  static const lightContainerborder = Color(0xffE7E7E7); 
  static const lightBgContainer = Color.fromARGB(255, 240, 249, 255);
  static const lightTextColorForBlueContainer = Color(0xFF7DA0CA);
  static const darkTextColorForBlueContainer = Color.fromARGB(255, 30, 63, 104);
}
