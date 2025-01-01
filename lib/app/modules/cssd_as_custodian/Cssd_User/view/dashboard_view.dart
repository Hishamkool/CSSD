import 'dart:developer';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/doctorProfileImage.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/endDrawer.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/pie_indicator.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/tabbar_dashboard.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  void initState() {
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "cssd");
    //check if you need to define it in bottomnav and dashboard also
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept);
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser);
    final dashboardController =
        Provider.of<DashboardController>(context, listen: false);
    dashboardController.getCssdRequestList();
    super.initState();
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
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AppBar(
                title: Padding(
                  padding: const EdgeInsets.only(left: 111.0),
                  child: Text(
                    "Hey, $userName",
                    style: FontStyles.appBarTitleStyle,
                  ),
                ),
                automaticallyImplyLeading: false,
                actions: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.alertViewCssdCusCssdLogin);
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
              Expanded(
                child: Container(
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
                                alignment: Alignment.topRight,
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
                                      titleStyle: FontStyles
                                          .piePercentageValueTextStyle,
                                      value: 33,
                                      color: StaticColors.pieRequestCount,
                                      radius: isMobile ? 26 : 33,
                                    ),
                                    PieChartSectionData(
                                      titleStyle: FontStyles
                                          .piePercentageValueTextStyle,
                                      value: 55,
                                      color: StaticColors
                                          .pieSterilizationOnProgress,
                                      radius: isMobile ? 26 : 33,
                                    ),
                                    PieChartSectionData(
                                      titleStyle: FontStyles
                                          .piePercentageValueTextStyle,
                                      value: 12,
                                      color:
                                          StaticColors.pieSterilizationComplete,
                                      radius: isMobile ? 26 : 33,
                                    ),
                                  ]),
                                ),
                              ),
                              const SizedBox(width: 15),
                              pieIndications(),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Today's Sterilization Requests ",
                                        style: GoogleFonts.plusJakartaSans(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: hexToColorWithOpacity(
                                                hexColor: "1C170D")),
                                      ),
                                      Consumer<DashboardController>(builder:
                                          (context, dashboardProvider, child) {
                                        return Text(
                                          "(${dashboardProvider.highPriorityRequestList.length + dashboardProvider.mediumPriorityRequestList.length + dashboardProvider.lowPriorityRequestList.length})",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: hexToColorWithOpacity(
                                                hexColor: "#003f5c"),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  IconButton(
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
                                      ))
                                  /*  ButtonWidget(
                                      borderRadius: 8,
                                      buttonTextSize: 14,
                                      buttonLabel: "ALL",
                                      onPressed: () {}), */
                                ],
                              ),
                              /* const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, bottom: 2.0),
                                  child: Text(
                                    "Priority : ",
                                  ),
                                ),
                              ), */
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
              ),
            ],
          ),
          // Hovering Doctor's Profile Image
          const Positioned(
            top: -20,
            left: 0,
            child:
                DoctorProfile(imageUrl: "assets/images/alosious edited1.png"),
          ),
        ],
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
      return const SizedBox.shrink(); // Return an empty widget if no privileges
    }
    // Return the floating action button if the privilege flag is true
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade100, width: 0.2),
          borderRadius: BorderRadius.circular(15)),
      child: FloatingActionButton.extended(
        elevation: 9,
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        label: const Text(
          "Switch to department",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context,
              Routes.dashboardViewCssdCussDeptUser, (Route route) => false);
        },
      ),
    );
  }
}
