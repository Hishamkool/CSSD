import 'dart:async';
import 'dart:developer';
import 'package:cssd/app/modules/Department_User/view/dept_dashboard_view_dept.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  static const  String backgroundImageSplash = "assets/images/5192479.jpg";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await precacheImage(const AssetImage(backgroundImageSplash), context);
      // check if you need this artificial delay 
      await Future.delayed(const Duration(milliseconds: 1500));
      await checkIfAlreadyLoggedin();
    });

    super.initState();
  }

  Future<void> checkIfAlreadyLoggedin() async {
    final bool? hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept);
    final String? currentToken =
        LocalStorageManager.getString(StorageKeys.loginToken);
    final List<String> privilegesList = LocalStorageManager.getStringList(
            StorageKeys.loggedinUserPrivilegesList) ??
        [];
    if (currentToken != null) {
      log("Token exists $currentToken");
      log("Previleges for the user : $hasPrivileges");
      if (privilegesList.contains("312") && privilegesList.contains("316")) {
        final String? lastOpenedCssd =
            LocalStorageManager.getString(StorageKeys.lastOpenedIsCssd);
        log("last opened page is: $lastOpenedCssd");
        if (lastOpenedCssd == "cssd") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarDashboardCssdUser,
            (Route<dynamic> route) => false,
          );
        } else if (lastOpenedCssd == "dept") {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.dashboardViewCssdCussDeptUser,
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.loginScreen,
            (Route<dynamic> route) => false,
          );
        }
      } else if (privilegesList.contains("312")) {
        LocalStorageManager.setBool(
            StorageKeys.privilegeFlagCssdAndDept, false);
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.bottomNavBarDashboardCssdUser,
            (Route<dynamic> route) => false);
      } else if (privilegesList.contains("316")) {
        LocalStorageManager.setBool(
            StorageKeys.privilegeFlagCssdAndDept, false);
        Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.dashboardViewCssdCussDeptUser,
            (Route<dynamic> route) => false);
      }
    } else if (currentToken == null) {
      Timer(
          const Duration(seconds: 1),
          () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // type: MaterialType.transparency,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImageSplash), fit: BoxFit.cover)
            /* gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: GradientColors.splashGradient), */
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
                     /*  shadows: <Shadow>[
                        Shadow(
                          offset: Offset(5.0, 7.0),
                          blurRadius: 3.0,
                          color: Colors.black26,
                        )] */
                    ),
                  ),
                  const Text(
                    "Centralized Sterilization and Supply Department",
                    style: TextStyle(fontSize: 16, color: Colors.white54),
                  ),
                ],
              ) .animate().fadeIn(duration: const Duration(seconds: 2),delay: const Duration(milliseconds: 150)),
                  ),
              Lottie.asset(
                "assets/lottie/loading_lottie.json",
                width: 80,
                frameRate: const FrameRate(90),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
