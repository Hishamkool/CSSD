import 'dart:developer';

import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DepartmentStockDetailsView extends StatefulWidget {
  const DepartmentStockDetailsView({super.key});

  @override
  State<DepartmentStockDetailsView> createState() =>
      _DepartmentStockDetailsViewState();
}

late String? selectedDepartment;

class _DepartmentStockDetailsViewState
    extends State<DepartmentStockDetailsView> {
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      if (selectedDepartment != null || selectedDepartment != "") {
        await dashboardController.filterFutureList("", selectedDepartment!);
      } else {
        showPackageToast(backgroundColor:Colors.red, text: "Select Department");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Department Stock Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: GradientColors.backgroundGradient)),
        child: SafeArea(
          child: ListView(
            children: [
              Consumer<DashboardControllerCssdCussDeptUser>(
                  builder: (context, dashboardConsumer, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextFormField(
                    hintText: "Search items",
                    // textFieldSize: Size(mediaQuery.width - 20.w, 0.0),
                    controller: dashboardConsumer.searchController,
                    onChanged: (query) {
                      if (selectedDepartment != null) {
                        log(query);
                        dashboardConsumer.filterFutureList(
                            query, selectedDepartment!);
                      } else {
                        showPackageToast(
                            backgroundColor: Colors.red,
                            text: "Select Department first");
                      }
                    },
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<DashboardControllerCssdCussDeptUser>(
                    builder: (context, dashboardConsumer, child) {
                  if (dashboardConsumer.filteredDeptStockList.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Empty-bro.svg",
                          height: 300,
                        ),
                        const Text("No item found"),
                      ],
                    );
                  }
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: dashboardConsumer.filteredDeptStockList.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400, mainAxisExtent: 70),
                    itemBuilder: (context, index) {
                      final product =
                          dashboardConsumer.filteredDeptStockList[index];
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Image.asset(
                              "assets/images/surgical-instrument.png"),
                          title: Text(
                            product.productName,
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("count :"),
                              Text(
                                " ${product.stock}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
