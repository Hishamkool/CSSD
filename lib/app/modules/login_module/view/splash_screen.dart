import 'dart:async';

import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // Timer(
    //     const Duration(seconds: 2),
    //     () => Navigator.pushNamedAndRemoveUntil(
    //           context,
    //           Routes.loginScreen,
    //           (route) => false,
    //         ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: GradientColors.splashGradient),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/sanitize_transparent.png",
                      width: 70,
                    ),
                    const Text(
                      "CSSD",
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        // shadows: <Shadow>[
                        //   Shadow(
                        //     offset: Offset(5.0, 7.0),
                        //     blurRadius: 3.0,
                        //     color: Colors.black26,
                        //   )]
                      ),
                    ),
                    const Text(
                      "Centralized Sterilization and Supply Department",
                      style: TextStyle(fontSize: 16, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Lottie.asset("assets/lottie/loading_lottie.json",
                  width: 80, frameRate: const FrameRate(90)),
            ],
          ),
        ),
      ),
    );
  }
}
