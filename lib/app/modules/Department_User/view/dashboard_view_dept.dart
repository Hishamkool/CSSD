import 'dart:developer';
import 'package:cssd/Widgets/notification_icon.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/build_floating_actions_widget.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/dahboard_buttons_widget.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        /*  showSnackBar(context: context, isError: true, msg: "Select department"); */
      }
    });
    // if user has both cssd and dept privileges
    hasPrivileges =
        LocalStorageManager.getBool(StorageKeys.privilegeFlagCssdAndDept)!;
    userName = LocalStorageManager.getString(StorageKeys.loggedinUser) ??
        "Department user";
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "dept");
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
                  Text("Hey, $userName", style: FontStyles.appBarTitleStyle),
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
              SizedBox(
                width: mediaQuery.width,
                height: 50,
                child: const DepartmentSelectionDashboardWidget(),
              )
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: ListView(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //pie chart
                        Consumer<DashboardControllerCssdCussDeptUser>(
                            builder: (context, dashboardConsumer, child) {
                          final isDataAvailable =
                              dashboardConsumer.hasValidData;
                          return Visibility(
                            visible: isDataAvailable ? true : false,
                            replacement: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Send Requests to load Stats"),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Lottie.asset(
                                      'assets/lottie/PieAnimation - 1731912508343.json'),
                                ),
                              ],
                            ),
                            //syncfusion pie chart
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
                                  hexToColorWithOpacity(hexColor: "#ff6361"),
                                  hexToColorWithOpacity(hexColor: "#58508d"),
                                  hexToColorWithOpacity(hexColor: "#bc5090"),
                                  hexToColorWithOpacity(hexColor: "#003f5c"),
                                  hexToColorWithOpacity(hexColor: "#ffa600"),
                                ],
                                title: const ChartTitle(
                                    alignment: ChartAlignment.near,
                                    text: 'Request Details',
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                legend: const Legend(
                                    //its the indications of the chart
                                    isVisible: true,
                                    textStyle: TextStyle(color: Colors.black),
                                    position: LegendPosition.right),
                                onTooltipRender: (TooltipArgs args) {},
                                series: <PieSeries<Map<String, dynamic>,
                                    String>>[
                                  PieSeries<Map<String, dynamic>, String>(
                                    dataSource: dashboardConsumer.pieChartData,
                                    explode: true,
                                    explodeIndex: 0,
                                    xValueMapper:
                                        (Map<String, dynamic> data, _) =>
                                            data.keys.first,
                                    yValueMapper:
                                        (Map<String, dynamic> data, _) =>
                                            data.values.first,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    )
                  ],
                ),
              ),

              //navigation buttons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  const DashboardButtons(
                    icon: FluentIcons.news_16_filled,
                    iconName: "Reports",
                  ),
                  // DashboardButtons(
                  //   icon: FluentIcons.timeline_20_filled,
                  //   iconName: "Timeline",
                  // ),
                  DashboardButtons(
                    icon: FluentIcons.stack_16_filled,
                    iconName: "Stock in Dept",
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routes.departmentStockDetailsView);
                    },
                  )
                ],
              ),

              //request listing
              Consumer<DashboardControllerCssdCussDeptUser>(
                  builder: (context, dashboardConsumer, child) {
                return RoundedContainer(
                  containerBody: Column(
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
                                  style: const TextStyle(
                                      fontSize: 25.0,
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
                                style: TextStyle(
                                    color: Colors.grey.shade300, fontSize: 14),
                              ),
                            ],
                          ),
                          EasyButton(
                            idleStateWidget: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                            loadingStateWidget: const CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                            useEqualLoadingStateWidgetDimension: true,
                            useWidthAnimation: false,
                            width: 100,
                            height: 30,
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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: dashboardConsumer.getMyRequestList.length,
                          itemBuilder: (context, index) {
                            final request =
                                dashboardConsumer.getMyRequestList[index];
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
                                    context: context,
                                    builder: (context) {
                                      return SizedBox.expand(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Items under the Request : ${request.reqId}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),

                                            //request details list
                                            const RequestDetailsTable()
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Card(
                                  elevation: 2,
                                  /* color: hexToColorWithOpacity(
                                    hexColor: "#FAF7F0",
                                  ), */
                                  color: const Color(0XFFf8f9fa),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // id
                                        Flexible(
                                            flex: 1,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2.0),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: hexToColorWithOpacity(
                                                    hexColor: "DD403A"),
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
                                            )),
                                        SizedBox(
                                          width: 8.0.w,
                                        ),
                                        //requested by and time
                                        Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // direction: Axis.vertical,
                                              children: [
                                                Text(
                                                  "Requested by : ${request.requser}",
                                                  overflow: TextOverflow.fade,
                                                ),
                                                Text("Date : $formatedDate"),
                                                Text("Time : $formatedTime"),
                                              ],
                                            )),
                                        SizedBox(
                                          width: 2.0.w,
                                        ),
                                        // accecpted ? by who
                                        Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text("Status : "),
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
                                                  ],
                                                ),
                                                request.isAccepted == true
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
                                                      ),
                                                request.isAccepted == true
                                                    ? Text(
                                                        "Accepted By: ${request.acceptedUser}",
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
