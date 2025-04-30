import 'dart:developer';
import 'package:cssd/Widgets/bottom_sheet_divider_widget.dart';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/view/stock_entry_dept_view.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/animation_bounce_up_dashboard.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/build_floating_actions_widget.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/department_dropdown_dashboard_widget.dart';
import 'package:cssd/Widgets/exit_dialogbox_widget.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/request_details_table_widget.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/show_department_selection_popup_widget.dart';
import 'package:cssd/app/modules/login_module/view/widgets/logout_popup.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardViewCssdCussDeptUser extends StatefulWidget {
  const DashboardViewCssdCussDeptUser({super.key});

  @override
  State<DashboardViewCssdCussDeptUser> createState() =>
      _DashboardViewCssdCussDeptUserState();
}

class _DashboardViewCssdCussDeptUserState
    extends State<DashboardViewCssdCussDeptUser> {
  late bool hasPrivileges;
  late String userName;
  late String? selectedDepartment;

  

  @override
  void initState() {
    super.initState();
    log("dashbord init");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardController =
          Provider.of<DashboardControllerCssdCussDeptUser>(context,
              listen: false);
      //fetch currently selected department and department lists
      selectedDepartment = dashboardController.getSelectedDepartment;
      dashboardController.departmentDropdownFunction();
      if (selectedDepartment != "") {
        //if department is selection is available then get pie data and its details
        log("Selected department is : $selectedDepartment");
        dashboardController.pieChartData.clear();
        dashboardController.getPieChartData(selectedDepartment!);
        dashboardController.fetchRequestDetails(selectedDepartment!);
        dashboardController.fetchMyRequests(selectedDepartment!);
      } else if (selectedDepartment == "") {
        // if department is not selected the show the popup
        log("no selected department : $selectedDepartment so showing popup");
        showAlertDialog(context);
        dashboardController.pieChartData.clear();
        /*  showSnackBar(context: context,   backgroundColor: Colors.red, msg: "Select department"); */
      }
    });
    // if user has both cssd and dept privileges
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept)!;
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser) ??
        "Department user";
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "dept");
  }

// for refresh inficator
  Future<void> refreshFunctions() async {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    //fetch currently selected department and department lists
    selectedDepartment = dashboardController.getSelectedDepartment;
    if (selectedDepartment != "") {
      //if department is selection is available then get pie data and its details
      dashboardController.pieChartData.clear();
      dashboardController.getPieChartData(selectedDepartment!);
      dashboardController.fetchRequestDetails(selectedDepartment!);
      dashboardController.fetchMyRequests(selectedDepartment!);
    } else if (selectedDepartment == "") {
      // if department is not selected the show the popup
      log("no selected department : $selectedDepartment so showing popup");
      showAlertDialog(context);
      dashboardController.pieChartData.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    log("dashboard page build");
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        exitDialogBox(context);
      },
      child: Scaffold(
        floatingActionButton: buildFloatingActionButton(hasPrivileges, context),
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        appBar: AppBar(
          toolbarHeight: 143,
          centerTitle: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            logoutPopup(context);
                          },
                          icon: const Icon(FluentIcons.power_20_filled)),
                      InkWell(onTap: () {}, child: const NotificationIcon()),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              //department dropdown
              const DepartmentSelectionDashboardWidget()
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: RefreshIndicator(
            onRefresh: refreshFunctions,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //pie chart
                          Consumer<DashboardControllerCssdCussDeptUser>(
                              builder: (context, dashboardConsumer, child) {
                            final isDataAvailable =
                                dashboardConsumer.hasValidData;
                            return Visibility(
                              visible: isDataAvailable ? true : false,
                              replacement: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Request Details",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: LottieBuilder.asset(
                                            repeat: true,
                                            reverse: true,
                                            'assets/lottie/PieAnimation - 1731912508343.json'),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      SizedBox(
                                          width: mediaQuery.width / 3.5,
                                          child: const Text(
                                              "Send Requests to load Stats")),
                                    ],
                                  ),
                                ],
                              ),
                              //syncfusion pie chart
                              child: Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  height: 180,
                                  child: SfCircularChart(
                                    /* onChartTouchInteractionDown:
                                        (ChartTouchInteractionArgs args) {
                                      log("${args.position.dy} : ${args.position.dy}");
                                      Navigator.pushNamed(
                                          context,
                                          Routes
                                              .requestDetailsViewCssdCussDeptUser);
                                    }, */
                                    palette: [
                                      //colors of the pie chart in order
                                      /*         hexToColorWithOpacity(hexColor: "#ff6361"),
                                      hexToColorWithOpacity(hexColor: "#58508d"),
                                      hexToColorWithOpacity(hexColor: "#bc5090"),
                                      hexToColorWithOpacity(hexColor: "#003f5c"),
                                      hexToColorWithOpacity(hexColor: "#ffa600"), */

                                      hexToColorWithOpacity(
                                          hexColor: "#7DA0CA"),
                                      hexToColorWithOpacity(
                                          hexColor: "#052659"),
                                    ],
                                    title: ChartTitle(
                                        alignment: ChartAlignment.near,
                                        text: 'Request Details',
                                        textStyle: GoogleFonts.plusJakartaSans(
                                            fontSize: 15.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600)),
                                    legend: const Legend(
                                        //its the indications of the chart
                                        isVisible: true,
                                        textStyle:
                                            TextStyle(color: Colors.black),
                                        position: LegendPosition.right),
                                    onTooltipRender: (TooltipArgs args) {},
                                    series: <PieSeries<Map<String, dynamic>,
                                        String>>[
                                      PieSeries<Map<String, dynamic>, String>(
                                        dataSource:
                                            dashboardConsumer.pieChartData,
                                        explode: true,
                                        explodeIndex: 0,
                                        xValueMapper:
                                            (Map<String, dynamic> data, _) =>
                                                data.keys.first,
                                        yValueMapper:
                                            (Map<String, dynamic> data, _) =>
                                                data.values.first,
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                          isVisible: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //navigation buttons
                /* Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardButtons(
                      icon: FluentIcons.tray_item_add_20_filled,
                      iconName: "Used Item Entry",
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.usedItemEntryViewCssdCussDeptUser);
                      },
                    ),
                    DashboardButtons(
                      icon: FluentIcons.send_16_filled,
                      iconName: "Send To Cssd",
                      onTap: () {
                        Navigator.pushNamed(context,
                            Routes.sterilizationRequestViewCssdCussDeptUser);
                      },
                    ),
                    DashboardButtons(
                      icon: FluentIcons.arrow_download_16_filled,
                      iconName: "Stock Entry",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const StockEntryDepartmentView(),
                            ));
                      },
                    ),
                    DashboardButtons(
                      icon: FluentIcons.stack_16_filled,
                      iconName: "Stock in Dept",
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.departmentStockDetailsView);
                      },
                    ),

                    /*  const DashboardButtons(
                      icon: FluentIcons.news_16_filled,
                      iconName: "Reports",
                    ),
                    const DashboardButtons(
                      icon: FluentIcons.timeline_20_filled,
                      iconName: "Timeline",
                    ), */
                  ],
                ) .animate().fade(duration: const Duration(seconds: 1)).moveY(),*/
                const SizedBox(
                  height: 20.0,
                ),
                //dashboard buttons with animations
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedDashboardButton(
                      icon: FluentIcons.tray_item_add_20_filled,
                      iconName: "Used Item Entry",
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.usedItemEntryViewCssdCussDeptUser);
                      },
                      index: 0,
                    ),
                    AnimatedDashboardButton(
                      icon: FluentIcons.send_16_filled,
                      iconName: "Send To Cssd",
                      onTap: () {
                        Navigator.pushNamed(context,
                            Routes.sterilizationRequestViewCssdCussDeptUser);
                      },
                      index: 1,
                    ),
                    AnimatedDashboardButton(
                      icon: FluentIcons.arrow_download_16_filled,
                      iconName: "Stock Entry",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StockEntryDepartmentView(),
                          ),
                        );
                      },
                      index: 2,
                    ),
                    AnimatedDashboardButton(
                      icon: FluentIcons.stack_16_filled,
                      iconName: "Stock in Dept",
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.departmentStockDetailsView);
                      },
                      index: 3,
                    ),
                  ],
                ),
                spaceH(10),
                //request listing
                Consumer<DashboardControllerCssdCussDeptUser>(
                    builder: (context, dashboardConsumer, child) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'My Requests ',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text:
                                          '(${dashboardConsumer.getMyRequestList.length})',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: hexToColorWithOpacity(
                                            hexColor: "#003f5c"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "requested to cssd",
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.grey.shade300, fontSize: 14),
                              ),
                            ],
                          ),
                          EasyButton(
                            idleStateWidget: const Center(
                              child: Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                            loadingStateWidget: const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                            width: 40,
                            height: 40,
                            useEqualLoadingStateWidgetDimension: false,
                            useWidthAnimation: true,
                            borderRadius: 4.0,
                            elevation: 2.0,
                            contentGap: 6.0,
                            buttonColor: StaticColors.scaffoldBackgroundcolor,
                            type: EasyButtonType.elevated,
                            onPressed: () async {
                              await dashboardController.fetchMyRequests(
                                  dashboardController.getSelectedDepartment);
                            },
                          ),
                          /*  ButtonWidget(
                                childWidget: Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                buttonTextSize: 14,
                                buttonSize: const Size(49, 30),
                                onPressed: () {},
                              ), */
                        ],
                      ),
                      // request list
                      Consumer<DashboardControllerCssdCussDeptUser>(
                          builder: (context, dashboardConsumer, child) {
                        if (dashboardConsumer.isLoading == true) {
                          return Center(
                            child: SizedBox(
                                width: 100,
                                height: 100,
                                child: LottieBuilder.asset(
                                    "assets/lottie/loading dots.json")),
                          );
                        }
                        if (dashboardConsumer.getMyRequestList.isEmpty) {
                          return LottieBuilder.asset(
                              "assets/lottie/Free search empty Animation.json");
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dashboardConsumer.getMyRequestList.length,
                          itemBuilder: (context, index) {
                            final request = dashboardConsumer
                                .getMyRequestList.reversed
                                .toList()[index];
                            String apiRequestTime = request.reqTime.toString();
                            DateTime parsedDateTime =
                                DateTime.parse(apiRequestTime);
                            String formatedDate =
                                DateFormat('yyyy-MM-dd').format(parsedDateTime);
                            String formatedTime =
                                DateFormat('hh:mm a').format(parsedDateTime);

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: InkWell(
                                onTap: () {
                                  //request details
                                  context
                                      .read<
                                          DashboardControllerCssdCussDeptUser>()
                                      .fetchMyRequestDetails(request.reqId);
                                  showModalBottomSheet(
                                    showDragHandle: true,
                                    isScrollControlled: true,
                                    backgroundColor:
                                        StaticColors.lightBgContainer,
                                    context: context,
                                    builder: (context) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // const BottomSheetDivider(),

                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Request ${request.reqId}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close))
                                              ],
                                            ),
                                          ),

                                          const Text(
                                            "Items within the request",
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          //request details list
                                          const RequestDetailsTable(),
                                          spaceH(40),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey.shade100,
                                      ),
                                      color: StaticColors.lightBgContainer),
                                  /* color: hexToColorWithOpacity(
                                    hexColor: "#FAF7F0",
                                  ), */
                                  // color: const Color(0XFFf8f9fa),
                                  /*  Banner(
                                      color: request.isAccepted == true
                                          ? Colors.green
                                          : Colors.red,
                                      location: BannerLocation.topEnd,
                                      message: request.isAccepted == true
                                          ? "Accepted"
                                          : "Pending", */
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            // id
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: hexToColorWithOpacity(
                                                    hexColor: "##042558"),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    " ${request.reqId} ",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8.0.w,
                                            ),
                                            //requested by and time
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // direction: Axis.vertical,
                                              children: [
                                                Text(
                                                  "Requested by : ${request.requser}",
                                                  style: GoogleFonts.varela(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: StaticColors
                                                          .darkTextColorForBlueContainer),
                                                  overflow: TextOverflow.fade,
                                                ),
                                                request.isAccepted == true
                                                    ? Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.verified,
                                                            size: 15,
                                                            color: Colors.green,
                                                          ),
                                                          const SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          Text(
                                                            "${request.acceptedUser}",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox.shrink(),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      FluentIcons
                                                          .calendar_12_filled,
                                                      size: 15,
                                                      color: StaticColors
                                                          .lightTextColorForBlueContainer,
                                                    ),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      formatedDate,
                                                      style: const TextStyle(
                                                          color: StaticColors
                                                              .lightTextColorForBlueContainer,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      FluentIcons
                                                          .clock_12_filled,
                                                      size: 15,
                                                      color: StaticColors
                                                          .lightTextColorForBlueContainer,
                                                    ),
                                                    const SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      formatedTime,
                                                      style: const TextStyle(
                                                          color: StaticColors
                                                              .lightTextColorForBlueContainer,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),

                                            // accecpted ? by who
                                            /* Expanded(
                                                flex: 2,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        /*  border: Border.all(
                                                              color: Colors.grey.shade100), */
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            request.isAccepted ==
                                                                    true
                                                                ? Colors.green
                                                                : Colors.red,
                                                        maxRadius: 4.0,
                                                      ),
                                                    ),
                                                    /* request.isAccepted == true
                                                        ? const Text(
                                                            "Accepted",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color:
                                                                    Colors.green),
                                                          )
                                                        : const Text(
                                                            "Not Accepted",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .redAccent),
                                                          ), */
                                                  ],
                                                )) ,*/
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                color:
                                                    request.isAccepted == true
                                                        ? Colors.green
                                                        : Colors.red),
                                            child: request.isAccepted == true
                                                ? const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.verified,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      Text(
                                                        "Accepted",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : const Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).animate().shimmer(
                            delay: const Duration(microseconds: 400),
                            duration: const Duration(milliseconds: 400));
                      }),
                    ],
                  );
                }),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
