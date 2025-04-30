import 'dart:ui';

import 'package:flutter/material.dart';

class TransparentBlurConatinerWidget extends StatelessWidget {
  final Widget bodyOfTransparentContainer;
  final Color colorOfTransparentContainer;
  final String? hexColor;
  final double? opacity;
  final BorderRadius borderRadius;
  final double? heightOfContainer;
  final EdgeInsets? containerPadding;
  final EdgeInsets? containerMargin;

  const TransparentBlurConatinerWidget({
    super.key,
    required this.bodyOfTransparentContainer,
    this.hexColor,
    this.opacity,
    required this.borderRadius,
    this.heightOfContainer = 310,
    this.colorOfTransparentContainer = const Color(0x265fadba),
    // this.colorOfTransparentContainer = const Color.fromARGB(35, 12, 12, 12),
    this.containerPadding,
    this.containerMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //backgrond container
        Container(
          padding: containerPadding,
          margin: containerMargin,
          height: heightOfContainer, // pass height
          decoration: BoxDecoration(
              color: colorOfTransparentContainer, //pass color
              borderRadius: borderRadius),
        ),
        //blur
        ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),

              height: heightOfContainer, // Set the height of the blur area
              width: double.infinity,
            ),
          ),
        ),
        // Content on top of the blur / body of the container
        bodyOfTransparentContainer
      ],
    );
  }
}
