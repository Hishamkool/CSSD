import 'package:flutter/material.dart';

/*usage 
Color customColor = hexToColorWithOpacity(hexColor: "#5FADBA", opacity: 0.15);  // 15% opacity
*/

Color hexToColorWithOpacity({required String hexColor,double opacity= 1.0}) {

  // Remove the '#' if present
  hexColor = hexColor.replaceAll('#', '');

  // Ensure the color is a valid 6-character hex code
  if (hexColor.length != 6) {
    throw ArgumentError("Hex color must be 6 characters long");
  }

  // Convert the opacity percentage to a hex value (0-255)
  int alpha = (opacity * 255).round();

  // Convert the hex color to an integer
  int colorValue = int.parse(hexColor, radix: 16);

  // Combine the alpha and color value to get the full ARGB color
  return Color((alpha << 24) | colorValue);
}
