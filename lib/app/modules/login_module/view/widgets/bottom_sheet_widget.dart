import 'dart:developer';

import 'package:cssd/app/modules/login_module/view/widgets/clickable_button_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> showOptionsBottomSheet(BuildContext context, Size mediaQuery) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Your Profile",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedHoverButton(
                      ontap: () {
                        log("button clicked");
                        /*  Navigator.pushNamedAndRemoveUntil(context,Routes.bottomNavBarDashboardCssdUser,(Route route) => false); */
                        Navigator.pushNamed(
                          context,
                          Routes.bottomNavBarDashboardCssdUser,
                        );
                      },
                      backgroundColor: StaticColors.scaffoldBackgroundcolor,
                      // backgroundColor:hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: Text(
                            "CSSD User",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 130,
                    ),
                    const Positioned(
                        left: -20,
                        bottom: -10,
                        child: SizedBox(
                          width: 50,
                          child: Image(
                              image:
                                  AssetImage("assets/images/disinfection.png")),
                        )),
                  ],
                ),
                SizedBox(
                  width: 20.w,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedHoverButton(
                      ontap: () {
                        log("button clicked");

                        Navigator.pushNamed(
                          context,
                          Routes.dashboardViewCssdCussDeptUser,
                        );
                      },
                      backgroundColor: StaticColors.scaffoldBackgroundcolor,
                      // backgroundColor: hexToColorWithOpacity(hexColor: "356745"),
                      hoverColor: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      buttonContent: Container(
                        color: Colors.transparent,
                        child: const Center(
                          child: FittedBox(
                            child: Text(
                              "Department User",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      containerHeight: 60,
                      containerWidth: 140,
                    ),
                    const Positioned(
                        left: -25,
                        bottom: -8,
                        child: SizedBox(
                          width: 45,
                          child: Image(
                              image:
                                  AssetImage("assets/images/department.png")),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      );
    },
  );
}
