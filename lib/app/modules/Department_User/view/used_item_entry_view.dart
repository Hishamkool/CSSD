import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/app/modules/Department_User/model/used_item_model/used_items_model.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/datagrid_used_item_entry_table_widget.dart';
import 'package:cssd/app/modules/Department_User/view/widgets/used_items_entry_widgets/items_for_selected_department_widget.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UsedItemEntryViewCssdCussDeptUser extends StatefulWidget {
  const UsedItemEntryViewCssdCussDeptUser({super.key});

  @override
  State<UsedItemEntryViewCssdCussDeptUser> createState() =>
      _UsedItemEntryViewCssdCussDeptUserState();
}

String? selectedDepartment;
final _formKey = GlobalKey<FormState>();

class _UsedItemEntryViewCssdCussDeptUserState
    extends State<UsedItemEntryViewCssdCussDeptUser> {
  List<UsedItemsListModelData> usedItems = [];
  late UsedItemsDataSource usedItemsDataSource;
  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;

    final usedItemsTable =
        Provider.of<UsedItemEntryController>(context, listen: false)
            .getUsedItemsTableBeforeSubmitList;
    usedItems = usedItemsTable;
    usedItemsDataSource = UsedItemsDataSource(usedItemsList: usedItems);
    log(usedItemsDataSource.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final usedItemsController =
        Provider.of<UsedItemEntryController>(context, listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title: Text('Used Item Entry', style: FontStyles.appBarTitleStyle),
        actions: [
          Tooltip(
            message: "List all used items",
            child: ButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, Routes.savedUsedItemsList);
              },
              childWidget: const Icon(
                FluentIcons.stack_16_filled,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
        
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(children: [
              SizedBox(
                height: 10.h,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 10.0,
                children: [
                  //select department dropdown
                  SizedBox(
                      width: mediaQuery.width,
                      child: Consumer<DashboardControllerCssdCussDeptUser>(
                          builder: (context, dashboardConsumer, child) {
                        if (dashboardConsumer.departmentDropdownItems.isEmpty) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final departmentNames = dashboardConsumer
                            .departmentDropdownItems
                            .map((dept) => dept.subName)
                            .toList();

                        return InputDecorator(
                          decoration: const InputDecoration(
                              label: Text("Select Department"),
                              border: InputBorder.none),
                          child: CustomDropdown.search(
                            closedHeaderPadding: const EdgeInsets.symmetric(
                                vertical: 11.0, horizontal: 10.0),
                            validator: (selectedDepartement) {
                              if (selectedDepartement == null ||
                                  selectedDepartement.isEmpty) {
                                return 'Select Department';
                              } else {
                                return null;
                              }
                            },
                            decoration: CustomDropdownDecoration(
                              closedBorder: Border.all(
                                  color: StaticColors.lightContainerborder),
                            ),
                            initialItem:
                                dashboardConsumer.getSelectedDepartment == ''
                                    ? null
                                    : dashboardConsumer.getSelectedDepartment,
                            hintText: "Department name",
                            searchHintText: "Search department name",
                            items: departmentNames,
                            onChanged: (selectedDepartment) {
                              //clear items and quantity
                              usedItemsController.quantityController.clear();
                              usedItemsController.setSelectedItemModel = null;
                              log("cleared items model , now the item name is: ${usedItemsController.getSelectedItemModel?.productName}");

                              if (selectedDepartment != null) {
                                dashboardConsumer.updateSelectedDepartment(
                                    selectedDepartment);
                              } else {
                                showToast(
                                    context: context,
                                    message: "Select department");
                              }
                            },
                          ),
                        );
                      })),
                  FetchItemsForSelectedDepartment(
                      dashboardController: dashboardController),
                  InputDecorator(
                    decoration: const InputDecoration(
                        label: Text("Quanity"),
                        border: InputBorder.none,
                        constraints: BoxConstraints(maxWidth: 80)),
                    child: CustomTextFormField(
                      // quantity dropdown
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      textFieldSize: const Size(80.0, 80.0),
                      label: const Text(
                        "Quantity",
                        style: TextStyle(fontSize: 14),
                      ),
                      onFieldSubmitted: (quantity) {
                        if (usedItemsController.getSelectedItemModel == null &&
                            selectedDepartment == null) {
                          showSnackBarNoContext(
                              isError: true, msg: "Select Dept / item first");
                          log("No items selected");
                        } else {
                          usedItemsController.qtyValidation(
                            isPckg: usedItemsController
                                        .getSelectedItemModel!.pckg ==
                                    1
                                ? true
                                : false,
                            location: selectedDepartment!,
                            productid:
                                usedItemsController.getSelectedItemModel!.pid!,
                            qty: int.parse(
                              quantity,
                            ),
                          );
                          log("isPckg: ${usedItemsController.getSelectedItemModel!.pckg == 1}");
                          log("location: $selectedDepartment");
                          log("productid: ${usedItemsController.getSelectedItemModel!.pid!}");
                          log("qty: ${int.parse(quantity)}");
                        }
                      },
                      validator: (quantity) {
                        if (quantity == null || quantity.isEmpty) {
                          return "Enter quantity";
                        }

                        if (usedItemsController.getSelectedItemModel == null) {
                          return "item null";
                        }
                        return null;
                      },
                      controller: usedItemsController.quantityController,
                    ),
                  ),
                  //add item button
                  ButtonWidget(
                      buttonSize: const Size(0.0, 50),
                      buttonLabel: "Add item",
                      buttonTextSize: 14,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final itemModel =
                              usedItemsController.getSelectedItemModel;
                          if (itemModel != null && selectedDepartment != null) {
                            /* if (itemModel.pckg == 1) {
                            //if slected item is a package then show bottom model sheet
                            final department = context
                                .read<DashboardControllerCssdCussDeptUser>()
                                .getSelectedDepartment;
                            //get items within the package -
                            context
                                .read<UsedItemEntryController>()
                                .fetchItemsWithPackage(
                                    department: department,
                                    pckid: itemModel
                                        .pid!); // pid is product id or package id

                            packageListingBottomSheet(
                              context,
                            );
                          } else { */
                            //if not package add it directly to the table

                            /* Quantity validation  do it later */
                            /*  bool isQntValid =
                                await usedItemsController.qtyValidation(
                              isPckg: itemModel.pckg == 1 ? true : false,
                              location: selectedDepartment!,
                              productid: itemModel.iid!,
                              qty: int.parse(
                                usedItemsController.quantityController.text ??
                                    "0",
                              ),
                            );
            
                            if (isQntValid) {
                              usedItemsController
                                  .addToUsedItemsTableBeforeSubmit(
                                productId: itemModel.iid!,
                                productName: itemModel.productName!,
                                location: selectedDepartment!,
                                uQty: int.parse(
                                  usedItemsController.quantityController.text,
                                ),
                              );
                            } */
                            usedItemsController.addToUsedItemsTableBeforeSubmit(
                              context: context,
                              productId: itemModel.iid!,
                              productName: itemModel.productName!,
                              location: selectedDepartment!,
                              uQty: int.parse(
                                usedItemsController.quantityController.text,
                              ),
                            );
                          }
                        } else {
                          showSnackBarNoContext(
                              isError: true, msg: "Some fields are missing");
                        }
                      }),
                ],
              ),
              SizedBox(height: 10.0.h),
              // sync fusion data grid table to list items
              Consumer<UsedItemEntryController>(
                  builder: (context, usedItemConsumer, child) {
                usedItemsDataSource = UsedItemsDataSource(
                    usedItemsList:
                        usedItemConsumer.getUsedItemsTableBeforeSubmitList);

                if (usedItemConsumer
                    .getUsedItemsTableBeforeSubmitList.isEmpty) {
                  return SfDataGrid(
                    columns: const [],
                    source: usedItemsDataSource,
                  );
                } else {
                  return SfDataGrid(
                    columnWidthMode: ColumnWidthMode.auto,
                    allowEditing: true,
                    source: usedItemsDataSource,
                    columns: <GridColumn>[
                      GridColumn(
                          columnName: "ProductID",
                          label: Container(
                            alignment: Alignment.center,
                            color: StaticColors.scaffoldBackgroundcolor,
                            child: const Text(
                              "PID.",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )),
                      GridColumn(
                          columnWidthMode: ColumnWidthMode.auto,
                          columnName: "ProductName",
                          label: Container(
                            alignment: Alignment.center,
                            color: StaticColors.scaffoldBackgroundcolor,
                            child: const Text(
                              "Product Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )),
                      GridColumn(
                          columnName: "UQty",
                          label: Container(
                            alignment: Alignment.center,
                            color: StaticColors.scaffoldBackgroundcolor,
                            child: const Text(
                              "Quantity",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          )),
                      GridColumn(
                        columnName: "Location",
                        label: Container(
                          alignment: Alignment.center,
                          color: StaticColors.scaffoldBackgroundcolor,
                          child: const Text(
                            "Location",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  );
                }
              }),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    buttonLabel: "Reset",
                    buttonTextSize: 14,
                    onPressed: () {
                      customDialog(
                          dialogContext: context,
                          dialogShowDefaultActions: false,
                          dialogTitle: const Text("Delete entries"),
                          dialogActions: [
                            ButtonWidget(
                              borderRadius: 10,
                              buttonLabel: "No",
                              buttonTextSize: 14,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ButtonWidget(
                              borderRadius: 10,
                              buttonLabel: "Yes",
                              buttonTextSize: 14,
                              onPressed: () {
                                usedItemsController
                                    .clearusedItemsTableBeforeSubmitList();
                                Navigator.pop(context);
                              },
                            )
                          ],
                          dialogContent: const Text(
                              "Are you sure you want to clear all the items in the table ?"));
                    },
                  ),
                  ButtonWidget(
                    buttonLabel: "Save Used Items",
                    buttonTextSize: 14,
                    onPressed: () {
                      usedItemsController.submitUsedItemsEntries().then((_) {
                        usedItemsController
                            .clearusedItemsTableBeforeSubmitList();
                      });
                    },
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
