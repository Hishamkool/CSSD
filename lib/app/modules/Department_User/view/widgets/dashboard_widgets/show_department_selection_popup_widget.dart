import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/view/department_stock_details_view.dart';
import 'package:cssd/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future showAlertDialog(BuildContext context) async {
  final dashboardController =
      Provider.of<DashboardControllerCssdCussDeptUser>(context, listen: false);
  dashboardController.departmentDropdownFunction();
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        actions: [
          ButtonWidget(
            buttonColor: const Color.fromARGB(255, 48, 160, 85),
            buttonLabel: "ok",
            onPressed: () {
              selectedDepartment = dashboardController.getSelectedDepartment;
              if (selectedDepartment == null || selectedDepartment == "") {
                showPackageToast(
                    backgroundColor:Colors.red,text: "Select Department");
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
        title: const Text("Select department"),
        content: Consumer<DashboardControllerCssdCussDeptUser>(
            builder: (context, dashboardConsumer, child) {
          return CustomDropdown.search(
             closedHeaderPadding:const EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
            decoration: CustomDropdownDecoration(
                closedBorder: Border.all(color: Colors.grey.shade100)),
            hintText: "Department name",
            items: dashboardConsumer.departmentDropdownItems
                .map((item) => item.subName.toString())
                .toList(),
            onChanged: (selectedDepartment) {
              if (selectedDepartment != null) {
                dashboardController
                    .updateSelectedDepartment(selectedDepartment);
              } else {
                showPackageToast( text: "Select department");
              }
            },
          );
        }),
      );
    },
  );
}
