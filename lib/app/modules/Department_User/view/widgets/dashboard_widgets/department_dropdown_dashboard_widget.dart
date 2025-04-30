import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DepartmentSelectionDashboardWidget extends StatelessWidget {
  const DepartmentSelectionDashboardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        context.read<DashboardControllerCssdCussDeptUser>();
    return Consumer<DashboardControllerCssdCussDeptUser>(
        builder: (context, dashboardConsumer, child) {
      if (dashboardConsumer.departmentDropdownItems.isEmpty) {
        return Center(
            child: SizedBox(
              height: 50,width: 100,
              child: Lottie.asset("assets/lottie/dot_loading_animation.json")));
      }

      final departmentNames = dashboardConsumer.departmentDropdownItems
          .map((dept) => dept.subName)
          .toList();

      return CustomDropdown.search(
        decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: StaticColors.lightContainerborder),
            closedSuffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
            ) /*  closedBorder: Border.all(color: Colors.grey) */),
        initialItem: dashboardConsumer.getSelectedDepartment == ''
            ? null
            : dashboardConsumer.getSelectedDepartment,
        hintText: "Department name",
        searchHintText: "Search department name",
        items: departmentNames,
        onChanged: (selectedDepartment) {
          if (selectedDepartment != null) {
            dashboardController.updateSelectedDepartment(selectedDepartment);
            dashboardController.fetchMyRequests(selectedDepartment);
            dashboardController.getPieChartData(
                selectedDepartment); // should not fetch pie chart data while changing dept from pages other than dashboard
          } else {
            showPackageToast( text: "Select department");
          }
        },
      );
    });
  }
}
