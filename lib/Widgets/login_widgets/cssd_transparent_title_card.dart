import 'dart:ui';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransparentTitleCardLogin extends StatelessWidget {
  final Color? backgroundColor;
  const TransparentTitleCardLogin({
    super.key,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Stack(
      children: [
        //backgrond container
        Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: backgroundColor ??
                hexToColorWithOpacity(hexColor: "5FADBA", opacity: 0.15),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(27),
              bottomRight: Radius.circular(27),
            ),
          ),
        ),

        //blur
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(27),
            bottomRight: Radius.circular(27),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),

              height: 200.h, // Set the height of the blur area
              width: double.infinity,
            ),
          ),
        ),
        // Content on top of the blur
        Container(
          height: 160.h,
          alignment: Alignment.bottomCenter,
          // color: Colors.amber,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Spacer(),
              const Text(
                "CSSD",
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fade(
                    curve: Curves.ease,
                    duration: const Duration(seconds: 1),
                  ),
              SizedBox(height: 20.h),
              AnimatedCrossFade(
                crossFadeState: MediaQuery.of(context).viewInsets.bottom > 0
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 400),
                firstChild: const Text(
                  "Where quality control meets life-saving care",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 19),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ).animate().fade(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeInBack),
                secondChild: const Text(
                  "Login",
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
