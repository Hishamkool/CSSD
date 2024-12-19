import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/alert_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/dashboard_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/issue_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/pickup_page.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/request_details_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/requests_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/sterilization_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/bottom_navigation_bar_cssd_user.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/timeline_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/saved_used_items_list_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/dashboard_view_dept.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/department_stock_details_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/send_to_cssd_view.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Department_User/view/used_item_entry_view.dart';
import 'package:cssd/app/modules/login_module/view/login_screen.dart';
import 'package:cssd/app/modules/login_module/view/splash_screen.dart';
// import 'package:cssd/app/modules/login_module/view/dashboard_switch_cssd_dept.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashScreen = '/';
  static const String loginScreen = '/loginScreen';
  // static const String switchBetweenCssdAndDepartment = '/SwitchBetweenCssdAndDepartment';

  /*cssd pages  -- cssd custodian ------------------------------------------------------------------------*/
  static const String bottomNavBarDashboardCssdUser =
      '/BottomNavigationBarDashboardCssdUser';
  static const String dashboardViewCssdCssCssdLogin =
      '/DashboardViewCssdCssCssdLogin';
  static const String alertViewCssdCusCssdLogin = '/AlertViewCssdCusCssdLogin';
  static const String requestsViewCssdCussCssdLogin =
      '/RequestsViewCssdCussCssdLogin';
  static const String requestDetailsViewCssdCussCssLogin =
      '/RequestDetailsViewCssdCussCssLogin';
  static const String sterilizationViewCssdCussCssdLogin =
      '/SterilizationViewCssdCussCssdLogin';
  static const String pickupPageCssdCussCssdLogin =
      '/PickupPageCssdCussCssdLogin';
  static const String issueViewCssdCussCssdLogin =
      '/IssueViewCssdCussCssdLogin';
  static const String timelineViewCssdCussCssdLogin =
      '/TimelineViewCssdCussCssdLogin';

  /*Department pages  -- cssd custodian--------------------------------------------------------------*/
  static const String dashboardViewCssdCussDeptUser =
      '/DashboardViewCssdCussDeptUser';
  static const String sterilizationRequestViewCssdCussDeptUser =
      '/SterilizationRequestViewCssdCussDeptUser';
  /*  static const String requestDetailsViewCssdCussDeptUser =
      '/RequestDetailsViewCssdCussDeptUser';
 */
  static const String departmentStockDetailsView =
      "/DepartmentStockDetailsView";
  static const String usedItemEntryViewCssdCussDeptUser =
      "/UsedItemEntryViewCssdCussDeptUser";

  static const String savedUsedItemsList = "/SavedUsedItemsList";
  /* ################################################################################################################# */

  static final Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const Splash(),
    loginScreen: (context) => const LoginScreen(),
    // switchBetweenCssdAndDepartment: (context) => const SwitchBetweenCssdAndDepartment(), //removed

    /*cssd pages -- cssd custodian-----------------------------------------------------------------------*/
    bottomNavBarDashboardCssdUser: (context) =>
        const BottomNavigationBarDashboardCssdUser(), //home page of cssd
    dashboardViewCssdCssCssdLogin: (context) =>
        const DashboardViewCssdCssCssdLogin(),
    alertViewCssdCusCssdLogin: (context) => const AlertViewCssdCusCssdLogin(),
    requestsViewCssdCussCssdLogin: (context) =>
        const RequestsViewCssdCussCssdLogin(),
    requestDetailsViewCssdCussCssLogin: (context) =>
        const RequestDetailsViewCssdCussCssLogin(),
    sterilizationViewCssdCussCssdLogin: (context) =>
        const SterilizationViewCssdCussCssdLogin(),
    pickupPageCssdCussCssdLogin: (context) =>
        const PickupPageCssdCussCssdLogin(),
    issueViewCssdCussCssdLogin: (context) => const IssueViewCssdCussCssdLogin(),
    timelineViewCssdCussCssdLogin: (context) =>
        const TimelineViewCssdCussCssdLogin(),

    /*Department pages  -- cssd custodian-------------------------------------------------------------------*/
    dashboardViewCssdCussDeptUser: (context) =>
        const DashboardViewCssdCussDeptUser(), //home
    sterilizationRequestViewCssdCussDeptUser: (context) =>
        const SterilizationRequestViewCssdCussDeptUser(),
    /* requestDetailsViewCssdCussDeptUser: (context) =>
        RequestDetailsViewCssdCussDeptUser(), */

    departmentStockDetailsView: (context) => const DepartmentStockDetailsView(),
    usedItemEntryViewCssdCussDeptUser: (context) =>
        const UsedItemEntryViewCssdCussDeptUser(),
    savedUsedItemsList: (context) => const SavedUsedItemsList(),
  };
}

/*  ################################################################################################################# */

/*  Navigations 


 Navigator.pushNamedAndRemoveUntil(
   context,
  Routes.home,
   (Route<dynamic> route) => false, 
 );

 Navigator.pushReplacementNamed(context, Routes.login);

 Navigator.pushNamed(context, Routes.details);

 Navigator.pushNamed(
   context,
   Routes.deviceSettings,
   arguments: {
     'name': 'ExampleName',
     'id': 'ExampleID',
   },
 );

 Navigator.popUntil(context, ModalRoute.withName(Routes.home));

 */
