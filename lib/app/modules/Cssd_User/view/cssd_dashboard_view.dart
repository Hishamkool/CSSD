import 'dart:developer';
import 'package:cssd/Widgets/doctorProfileImage.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/pie_indicator.dart';
import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/dashboard_widgets/tabbar_dashboard.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DashboardViewCssdCssCssdLogin extends StatefulWidget {
  const DashboardViewCssdCssCssdLogin({super.key});

  @override
  State<DashboardViewCssdCssCssdLogin> createState() =>
      _DashboardViewCssdCssCssdLoginState();
}

class _DashboardViewCssdCssCssdLoginState
    extends State<DashboardViewCssdCssCssdLogin> {
  bool? hasPrivileges;
  String? userName;
  bool isLoadingRequestsApi = false;
  @override
  void initState() {
    super.initState();
    final dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    log("length of high priority : ${dashboardController.highPriorityRequestList.length}");
    // dashboardController.clearRequestList();
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept);
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "cssd");
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dashboardController.getCssdRequestList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    /* final dashboardController =
        Provider.of<DashboardController>(context, listen: false); */

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(hasPrivileges),
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            const SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                  child: Image(
                image: AssetImage("assets/images/user.png"),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Hey, $userName",
                style: FontStyles.appBarTitleStyle,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.alertViewCssdCusCssdLogin);
              },
              child: const NotificationIcon()),
          const SizedBox(width: 10),
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, size: 30),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Request Chart",
                        style: FontStyles.bodyPieTitleStyle,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isMobile ? 120 : 150,
                      width: isMobile ? 120 : 150,
                      child: PieChart(
                        swapAnimationDuration:
                            const Duration(microseconds: 900),
                        swapAnimationCurve: Curves.easeIn,
                        PieChartData(sections: [
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 33,
                            color: StaticColors.pieRequestCount,
                            radius: isMobile ? 26 : 33,
                          ),
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 55,
                            color: StaticColors.pieSterilizationOnProgress,
                            radius: isMobile ? 26 : 33,
                          ),
                          PieChartSectionData(
                            titleStyle: FontStyles.piePercentageValueTextStyle,
                            value: 12,
                            color: StaticColors.pieSterilizationComplete,
                            radius: isMobile ? 26 : 33,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(width: 15),
                    pieIndications(),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<DashboardController>(
                              builder: (context, dashboardProvider, child) {
                            // to get the text width
                            const titleForRequests =
                                "Today's Sterilization request";

                            final titleForRequestsStyle =
                                GoogleFonts.plusJakartaSans(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: hexToColorWithOpacity(
                                        hexColor: "1C170D"));
                            final textSpan = TextSpan(
                                text: titleForRequests,
                                style: titleForRequestsStyle);

                            final textPainter = TextPainter(
                                text: textSpan,
                                textDirection: TextDirection.ltr)
                              ..layout();

                            final textWidth = textPainter.width;
                            final textHeight = textPainter.height;
                            //
                            return GestureDetector(
                              onTap: () {
                                final dashboardController =
                                    Provider.of<DashboardController>(context,
                                        listen: false);
                                dashboardController.getCssdRequestList();
                              },
                              child: Visibility(
                                visible:
                                    dashboardProvider.isLoadingRequestsApi ==
                                        false,
                                replacement: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxHeight: textHeight,
                                    minWidth: textWidth,
                                  ),
                                  child: LottieBuilder.asset(
                                    "assets/lottie/dot_loading_animation.json",
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      titleForRequests,
                                      style: titleForRequestsStyle,
                                    ),
                                    Text(
                                      "(${dashboardProvider.highPriorityRequestList.length + dashboardProvider.mediumPriorityRequestList.length + dashboardProvider.lowPriorityRequestList.length})",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: hexToColorWithOpacity(
                                            hexColor: "#003f5c"),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),

                          // to search request based on from and to date -- search button
                          Visibility(
                            visible: isMobile,
                            replacement: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      Routes
                                          .searchRequestsViewCssdCussCssdLogin);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      FluentIcons.search_12_filled,
                                      color: hexToColorWithOpacity(
                                          hexColor: "#003f5c"),
                                    ),
                                    const Text(
                                      "Search Requests",
                                      style: TextStyle(
                                          color: StaticColors
                                              .scaffoldBackgroundcolor),
                                    )
                                  ],
                                )),
                            child: IconButton(
                                hoverColor: Colors.amber,
                                tooltip: "Search Requests",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      Routes
                                          .searchRequestsViewCssdCussCssdLogin);
                                },
                                icon: Icon(
                                  FluentIcons.search_12_filled,
                                  color: hexToColorWithOpacity(
                                      hexColor: "#003f5c"),
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Expanded(
                      child: TabBarDashboard(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column pieIndications() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Indicator(
          color: StaticColors.pieRequestCount,
          text: 'Request count',
          isSquare: false,
        ),
        SizedBox(height: 6),
        Indicator(
          color: StaticColors.pieSterilizationOnProgress,
          text: 'Sterilization on progress',
          isSquare: false,
        ),
        SizedBox(height: 6),
        Indicator(
          color: StaticColors.pieSterilizationComplete,
          text: 'Sterilization complete',
          isSquare: false,
        ),
        SizedBox(height: 4),
      ],
    );
  }

  Widget _buildFloatingActionButton(hasPrivileges) {
    log("Privilege Status: $hasPrivileges");

    // Check if the user does not have the required privilege
    if (!hasPrivileges) {
      // Return an empty widget if no privileges
      return const SizedBox.shrink();
    }
    // Return the floating action button if the privilege flag is true
    return SizedBox(
      width: 130,
      height: 50,
      child: FloatingActionButton(
        elevation: 9,
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: FittedBox(
            child: Text(
              "Switch to Dept",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context,
              Routes.dashboardViewCssdCussDeptUser, (Route route) => false);
        },
      ),
    );
  }
}



// Hovering Doctor's Profile Image
          /* const Positioned(
            top: -20,
            left: 0,
            child:
                DoctorProfile(imageUrl: "assets/images/alosious edited1.png"),
          ), */