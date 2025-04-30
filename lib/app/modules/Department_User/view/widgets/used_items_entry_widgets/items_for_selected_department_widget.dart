import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/used_items_entry_widgets/package_items_table_widget.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FetchItemsForSelectedDepartment extends StatefulWidget {
  const FetchItemsForSelectedDepartment({
    super.key,
    required this.dashboardController,
  });

  final DashboardControllerCssdCussDeptUser dashboardController;

  @override
  State<FetchItemsForSelectedDepartment> createState() =>
      _FetchItemsForSelectedDepartmentState();
}

class _FetchItemsForSelectedDepartmentState
    extends State<FetchItemsForSelectedDepartment> {
  late String? selectedDepartment;
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsedItemEntryController>(
        // items search suggestions
        builder: (context, usedItemEntryConsumer, child) {
      final dashboardController =
          Provider.of<DashboardControllerCssdCussDeptUser>(context,
              listen: false);

      selectedDepartment = dashboardController.getSelectedDepartment;
      return InputDecorator(
        decoration: const InputDecoration(
            label: Text("Search items or packages"), border: InputBorder.none),
        child: CustomDropdown.searchRequest(
          closedHeaderPadding:
              const EdgeInsets.symmetric(vertical: 11.0, horizontal: 10.0),
          onChanged: (selectedItemModel) {
            if (selectedItemModel != null) {
              // if package show bottom sheet
              if (selectedItemModel.pckg == 1) {
                log('currently selected package : ${selectedItemModel.productName}');
                usedItemEntryConsumer.setSelectedItemModel = selectedItemModel;
                final department = context
                    .read<DashboardControllerCssdCussDeptUser>()
                    .getSelectedDepartment;
                final usedItemsController =
                    Provider.of<UsedItemEntryController>(context,
                        listen: false);
                final itemModel = usedItemsController.getSelectedItemModel;
                /*  context.read<UsedItemEntryController>().fetchItemsWithPackage(
                    department: department, pckid: itemModel!.pid ?? 0);
                _showPackageListingBottomSheet(
                    context: context,
                    department: department,
                    itemModel: itemModel,
                    usedItemsController: usedItemsController); */
                if (itemModel != null) {
                  // Check if itemModel is not null
                  context.read<UsedItemEntryController>().fetchItemsWithPackage(
                      department: department, pckid: itemModel.pid ?? 0);
                  _showPackageListingBottomSheet(
                      context: context,
                      department: department,
                      itemModel: itemModel,
                      usedItemsController: usedItemsController);
                } else {
                  // Handle null itemModel here, show an error or fallback
                  showPackageToast(
                      backgroundColor: Colors.red, text: "Item model is null");
                }
              } else {
                // updating the selected item model
                log('currently selected item : ${selectedItemModel.productName}');
                usedItemEntryConsumer.setSelectedItemModel = selectedItemModel;
              }
            } else {
              showPackageToast(
                  backgroundColor: Colors.red, text: "selected item is null");
            }
          },
          futureRequestDelay: const Duration(milliseconds: 0),
          futureRequest: (stringItem) async {
            if (selectedDepartment == null) {
              showPackageToast(
                  backgroundColor: Colors.red,
                  text: "Select department to list items");
            } else {
              await usedItemEntryConsumer.fetchItems(
                  itemname: stringItem, department: selectedDepartment!);
            }
            /*  await usedItemEntryConsumer.fetchItems(
                itemname: stringItem,
                department: dashboardController.getSelectedDepartment!); */

            return usedItemEntryConsumer.getItemsList;
          },
          headerBuilder: (context, selectedItem, enabled) {
            if (usedItemEntryConsumer.getSelectedItemModel?.productName ==
                null) {
              return const Text("");
            }
            log("item model is ${usedItemEntryConsumer.getSelectedItemModel?.productName}");
            return Text(selectedItem.productName ?? "");
          },
          listItemBuilder: (context, item, isSelected, onItemSelect) =>
              ListTile(
            title: Text(item.productName ?? ""),
          ),
          decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: StaticColors.lightContainerborder),
          ),
          hintText: "Items",
          searchHintText: "Search items",
          hideSelectedFieldWhenExpanded: false,
          validator: (item) {
            if (item == null) {
              return "Choose an item or package";
            }
            return null;
          },
        ),
      );
    });
  }

  Future<void> _showPackageListingBottomSheet({
    required BuildContext context,
    required String department,
    required UsedItemEntryController usedItemsController,
    required dynamic itemModel,
  }) async {
    Size mediaQuery = MediaQuery.of(context).size;

    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: mediaQuery.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10.0.h,
                  ),
                  const Text(
                    "Select the items to add",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                      "Package : ${itemModel.productName} contains the following items"),
                  SizedBox(
                    height: 10.h,
                  ),
                  // table of package items
                  PackageItemsTableWidget(
                    pkgid: itemModel?.pid ?? 0,
                  ),
                ],
              ), //check
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          hexToColorWithOpacity(hexColor: "#7F3804"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: StaticColors.scaffoldBackgroundcolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Add items",
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        {
                          // add items within the package to table
                          usedItemsController.addPackageItemsToUSedItemsTable(
                              context: context, department: department);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
