import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/get_cssd_list_model.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/request_card_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/dashboard_widgets/tabbar_head_dahboard.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TabBarDashboard extends StatelessWidget {
  const TabBarDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Color(0xffDBEBF5),
            ),
            child: Consumer<DashboardController>(
                builder: (context, dashboardConsumer, child) {
              return TabBar(
                onTap: (value) {
                  dashboardConsumer.updateSelectedIndex(value);
                },
                indicatorPadding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
                indicator: BoxDecoration(
                    border: Border.all(color: Colors.black.withAlpha(10)),
                    color: const Color(0xffF0F5FA),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    )),
                labelStyle: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                    color: const Color(0xff307AB0),
                    fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                tabs: [
                  DashboardTabBarHead(
                    titleText: isMobile ? 'High ' : 'High Priority',
                    countText: dashboardConsumer.highPriorityRequestList.length
                        .toString(),
                    tabIndex: 0,
                  ),
                  DashboardTabBarHead(
                    titleText: isMobile ? 'Medium ' : 'Medium Priority',
                    countText: dashboardConsumer
                        .mediumPriorityRequestList.length
                        .toString(),
                    tabIndex: 1,
                  ),
                  DashboardTabBarHead(
                    titleText: isMobile ? 'Low ' : 'Low Priority',
                    countText: dashboardConsumer.lowPriorityRequestList.length
                        .toString(),
                    tabIndex: 2,
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _highPriorityTabView(),
                _mediumPriorityTabView(),
                _lowPriorityTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _highPriorityTabView() {
    return Consumer<DashboardController>(
        builder: (context, dashboardProvider, child) {
      return ListView.builder(
          itemCount: dashboardProvider.highPriorityRequestList.length,
          itemBuilder: (context, index) {
            final requestList =
                dashboardProvider.highPriorityRequestList[index];
            return Column(children: [
              RequestCard(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.requestDetailsViewCssdCussCssLogin,
                  arguments: requestList.sid,
                ),
                request: HighMedLowReqModel(
                    priority: requestList.priority,
                    remarks: requestList.remarks,
                    productdet: requestList.productdet,
                    rTime: requestList.rTime,
                    ruser: requestList.ruser,
                    sid: requestList.sid,
                    sub: requestList.sub),
              ),
            ]);
          });
    });
  }
}

Widget _mediumPriorityTabView() {
  return Consumer<DashboardController>(
      builder: (context, dashboardProvider, child) {
    return ListView.builder(
        itemCount: dashboardProvider.mediumPriorityRequestList.length,
        itemBuilder: (context, index) {
          final requestList =
              dashboardProvider.mediumPriorityRequestList[index];

          return Column(children: [
            RequestCard(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.requestDetailsViewCssdCussCssLogin,
                arguments: requestList.sid,
              ),
              request: HighMedLowReqModel(
                  priority: requestList.priority,
                  remarks: requestList.remarks,
                  productdet: requestList.productdet,
                  rTime: requestList.rTime,
                  ruser: requestList.ruser,
                  sid: requestList.sid,
                  sub: requestList.sub),
            ),
          ]);
        });
  });
}

Widget _lowPriorityTabView() {
  return Consumer<DashboardController>(
      builder: (context, dashboardProvider, child) {
    return ListView.builder(
        itemCount: dashboardProvider.lowPriorityRequestList.length,
        itemBuilder: (context, index) {
          final requestList = dashboardProvider.lowPriorityRequestList[index];
          return Column(children: [
            RequestCard(
              onTap: () => Navigator.pushNamed(
                context,
                Routes.requestDetailsViewCssdCussCssLogin,
                arguments: requestList.sid,
              ),
              request: HighMedLowReqModel(
                  priority: requestList.priority,
                  remarks: requestList.remarks,
                  productdet: requestList.productdet,
                  rTime: requestList.rTime,
                  ruser: requestList.ruser,
                  sid: requestList.sid,
                  sub: requestList.sub),
            ),
          ]);
        });
  });
}
