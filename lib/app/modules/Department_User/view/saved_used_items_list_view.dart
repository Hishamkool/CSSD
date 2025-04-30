import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SavedUsedItemsList extends StatefulWidget {
  const SavedUsedItemsList({super.key});

  @override
  State<SavedUsedItemsList> createState() => _SavedUsedItemsListState();
}

class _SavedUsedItemsListState extends State<SavedUsedItemsList> {
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final usedItemsControler =
        Provider.of<UsedItemEntryController>(context, listen: false);
    usedItemsControler.fetchDepartmentWiseUsedItems(
        dashboardController.getSelectedDepartment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final usedItemsControler =
        Provider.of<UsedItemEntryController>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Used Items List",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10.h,
            ),
            Consumer<DashboardControllerCssdCussDeptUser>(
                builder: (context, dashboardConsumer, child) {
              if (dashboardConsumer.departmentDropdownItems.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final departmentNames = dashboardConsumer.departmentDropdownItems
                  .map((dept) => dept.subName)
                  .toList();

              return CustomDropdown.search(
                decoration: const CustomDropdownDecoration(
                    closedSuffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                )),
                initialItem: dashboardConsumer.getSelectedDepartment == ""
                    ? null
                    : dashboardConsumer.getSelectedDepartment,
                hintText: "Department name",
                searchHintText: "Search department name",
                items: departmentNames,
                onChanged: (selectedDepartment) {
                  if (selectedDepartment != null) {
                    dashboardConsumer
                        .updateSelectedDepartment(selectedDepartment);
                    usedItemsControler.fetchDepartmentWiseUsedItems(
                        dashboardConsumer.getSelectedDepartment);
                  } else {
                    showPackageToast( text: "Select department");
                  }
                },
              );
            }),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
        toolbarHeight: 120,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Expanded(child: Consumer<UsedItemEntryController>(
              builder: (context, usedItemsConsumer, child) {
            return ListView.builder(
              itemCount:
                  usedItemsConsumer.getDepartmentWiseUsedItemsList.length,
              itemBuilder: (context, index) {
                final item =
                    usedItemsConsumer.getDepartmentWiseUsedItemsList[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff7474bf), Color(0xff348ac7)],
                          stops: [0, 1],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product name: ${item.productName}",
                            style: FontStyles.savedUsedItems),
                        Text("Used Items quantity: ${item.uQty}",
                            style: FontStyles.savedUsedItems),
                        Text("Product id: ${item.productId}",
                            style: FontStyles.savedUsedItems),
                      ],
                    ),
                  ),
                );
              },
            );
          }))
        ],
      ),
    );
  }
}
