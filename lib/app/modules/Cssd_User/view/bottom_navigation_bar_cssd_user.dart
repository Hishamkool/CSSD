import 'package:cssd/Widgets/exit_dialogbox_widget.dart';
import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/Cssd_User/view/cssd_dashboard_view.dart';
import 'package:cssd/app/modules/Cssd_User/view/issue_view.dart';
import 'package:cssd/app/modules/Cssd_User/view/pickup_page.dart';
import 'package:cssd/app/modules/Cssd_User/view/sterilization_view.dart';
import 'package:cssd/app/modules/Cssd_User/view/timeline_view.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/local_storage_manager.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarDashboardCssdUser extends StatelessWidget {
  const BottomNavigationBarDashboardCssdUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LocalStorageManager.setString(StorageKeys.lastOpenedIsCssd, "cssd");
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    final dashboardProvider =
        Provider.of<DashboardController>(context, listen: false);
    void onBottomItemTap(int index) {
      dashboardProvider.updateBottomNav(index);
    }

    List<Widget> screens = [
      const DashboardViewCssdCssCssdLogin(),
      // const RequestsViewCssdCussCssdLogin(),
      const SterilizationViewCssdCussCssdLogin(),
      const PickupPageCssdCussCssdLogin(),
      const IssueViewCssdCussCssdLogin(),
      const TimelineViewCssdCussCssdLogin()
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        exitDialogBox(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Consumer<DashboardController>(
            builder: (context, dashboardController, child) {
          return CurvedNavigationBar(
            height: isMobile ? 50 : 60,
            backgroundColor: Colors.white,
            color: StaticColors.scaffoldBackgroundcolor,
            onTap: (value) {
              onBottomItemTap(value);
            },
            items: const [
              Icon(
                FluentIcons.home_12_filled,
                semanticLabel: 'Home',
                color: Colors.white,
              ),
              /*  Icon(
                FluentIcons.branch_request_16_filled,
                color: Colors.white,
              ), */
              Icon(
                FluentIcons.paint_brush_16_filled,
                color: Colors.white,
              ),
              Icon(
                FluentIcons.tray_item_add_20_filled,
                color: Colors.white,
              ),
              Icon(
                FluentIcons.vehicle_truck_profile_16_filled,
                color: Colors.white,
              ),
              Icon(
                FluentIcons.timeline_24_filled,
                color: Colors.white,
              ),
            ],
          );
        }),
        body: Consumer<DashboardController>(
          builder: (context, dashboardController, child) =>
              screens[dashboardController.selectedIndexBotomNav],
        ),
      ),
    );
  }
}




/*

Default navigation bar 

import 'package:cssd/feature/cssd_as_custodian/Cssd_User/provider/dashboard_controller.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/dashboard_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/issue_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/pickup_page.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/requests_view.dart';
import 'package:cssd/feature/cssd_as_custodian/Cssd_User/view/sterilization_view.dart';
import 'package:cssd/util/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarDashboard extends StatelessWidget {
  const BottomNavigationBarDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardProvider =
        Provider.of<DashboardController>(context, listen: false);
    void onBottomItemTap(int index) {
      dashboardProvider.updateBottomNav(index);
    }

    List<Widget> screens = [
      const DashboardViewCssdCssCssdLogin(),
      const RequestsViewCssdCussCssdLogin(),
      const SterilizationViewCssdCussCssdLogin(),
      const PickupPageCssdCussCssdLogin(),
      const IssueViewCssdCussCssdLogin()
    ];

    return Scaffold(
      bottomNavigationBar: Consumer<DashboardController>(
          builder: (context, dashboardController, child) {
        return BottomNavigationBar(
          backgroundColor: Colors.amber,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_12_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.branch_request_16_filled),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
                icon: Icon(FluentIcons.paint_brush_32_regular),
                label: 'Sterilize',
                activeIcon: Icon(FluentIcons.paint_brush_12_filled)),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.tray_item_add_20_filled),
              label: 'Pickup',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.vehicle_truck_profile_16_filled),
              label: 'Issue',
            ),
            BottomNavigationBarItem(
              icon: Icon(FluentIcons.timeline_24_filled),
              label: 'Timeline',
            ),
          ],
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(255, 116, 116, 116),
          currentIndex: dashboardController.selectedIndexBotomNav,
          selectedItemColor: StaticColors.scaffoldBackgroundcolor,
          onTap: onBottomItemTap,
        );
      }),
      body: Consumer<DashboardController>(
        builder: (context, dashboardController, child) =>
            screens[dashboardController.selectedIndexBotomNav],
      ),
    );
  }
} 

*/