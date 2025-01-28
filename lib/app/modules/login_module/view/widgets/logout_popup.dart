import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/login_module/controller/login_controller.dart';
import 'package:cssd/main.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> logoutPopup(BuildContext context) async {
  final loginController = Provider.of<LoginController>(context, listen: false);
  final dahboardController =
      Provider.of<DashboardControllerCssdCussDeptUser>(context, listen: false);
  return customDialog(
    dialogContext: context,
    dialogContent: const Text("Are you sure to logout?"),
    dialogShowDefaultActions: true,
    defaultAcceptText: "Logout",
    defaultCancelText: "Cancel",
    onAcceptDefaultAction: () async {
      // create the logout function here
      // final dashboardController = Provider.of<DashboardControllerCssdCussDeptUser>(
      //     context,
      //     listen: false);

      await loginController.logoutFunction(context);
      dahboardController.pieChartData.clear();
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.loginScreen, (route) => false);
      // clear the local storage on logout
    },
    onCancelDefaultAction: () {
      Navigator.pop(context);
    },
  );
}
