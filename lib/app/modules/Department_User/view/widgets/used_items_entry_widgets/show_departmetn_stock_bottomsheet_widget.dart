import 'package:cssd/Widgets/bottom_sheet_divider_widget.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/used_item_entry_controller.dart';
import 'package:cssd/util/app_util.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

void showDepartmentStockBottomSheet(BuildContext context) {
  // final dashboardController = Provider.of<DashboardControllerCssdCussDeptUser>(context,listen: false);
  showModalBottomSheet(
    
    context: context,
    isScrollControlled: true,
    isDismissible: true,

    // backgroundColor: const Color.fromARGB(255, 233, 238, 255),
    backgroundColor: Colors.transparent,
    builder: (context) => const DepartmentStockSheetContent(),
  );
}

// Modified widget for bottom sheet content
class DepartmentStockSheetContent extends StatefulWidget {
  const DepartmentStockSheetContent({super.key});

  @override
  State<DepartmentStockSheetContent> createState() =>
      _DepartmentStockSheetContentState();
}

class _DepartmentStockSheetContentState
    extends State<DepartmentStockSheetContent> {
  late String? selectedDepartment;

  @override
  void initState() {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;
    WidgetsBinding.instance.addPostFrameCallback((callback) async {
      if (selectedDepartment != null && selectedDepartment!.isNotEmpty) {
        await dashboardController.filterFutureList("", selectedDepartment!);
        // creating unique formkeys for quantity field in bottom sheet
        dashboardController.initializeFormKeys(
          dashboardController.filteredDeptStockList.length,
        );
        // creating unique controllers for quantity field in bottom sheet
        dashboardController.initializeControllers(
          dashboardController.filteredDeptStockList.length,
        );
      } else {
        showPackageToast(
            backgroundColor: Colors.red, text: "Select Department");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //is keyboard not visible
    // final isKeyboardNotVisible = mediaQuery.viewInsets.bottom <= 0;

    return Consumer<DashboardControllerCssdCussDeptUser>(
        builder: (context, dashboardConsumer, child) {
      return makeDismissable(
        child: Padding(
          padding: EdgeInsets.only(
              top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.1,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.fastOutSlowIn,
                /*  height: /* isKeyboardNotVisible
                    ? mediaQuery.size.height /3
                    :  */
                    dashboardConsumer.isSearchFocused
                        ? mediaQuery.size.height
                        : mediaQuery.size.height / 2, */
                child: Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Color.fromARGB(255, 233, 238, 255),
                    ),
                    /* padding: EdgeInsets.only(
                        top: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom), */
                    child: ListView(
                      shrinkWrap: true,
                      controller: scrollController,
                      children: [
                        const Align(
                            alignment: Alignment.center,
                            child: BottomSheetDivider()),
                        // Header
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Department Stock Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              IconButton(
                                icon:
                                    const Icon(FluentIcons.dismiss_24_regular),
                                onPressed: () {
                                  Navigator.pop(context);
                                  final dashboardController = Provider.of<
                                          DashboardControllerCssdCussDeptUser>(
                                      context,
                                      listen: false);
                                  dashboardController.searchController.clear();
                                },
                              ),
                            ],
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "select items to add as used items",
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey[100],
                        ),
                        // Content
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<DashboardControllerCssdCussDeptUser>(
                            builder: (context, dashboardConsumer, child) {
                              return Column(
                                children: [
                                  // Search field
                                  CustomTextFormField(
                                    focusNode:
                                        dashboardConsumer.searchFieldFocus,
                                    onTap: () {},
                                    hintText: "Search items",
                                    controller:
                                        dashboardConsumer.searchController,
                                    onFieldSubmitted: (p0) {},
                                    onChanged: (query) {
                                      if (selectedDepartment != null) {
                                        dashboardConsumer.filterFutureList(
                                            query, selectedDepartment!);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // List content
                                  _buildStockList(dashboardConsumer),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
      );
    });
  }

  Widget _buildStockList(DashboardControllerCssdCussDeptUser controller) {
    if (controller.filteredDeptStockList.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/Empty-bro.svg",
            height: 150,
          ),
          const Text("No items found", style: TextStyle(fontSize: 16)),
        ],
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.filteredDeptStockList.length,
      itemBuilder: (context, index) {
        final product = controller.filteredDeptStockList[index];

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              showTrailingIcon: false,
              title: ListTile(
                leading: Image.asset("assets/images/surgical-instrument.png",
                    width: 40),
                title: Text(
                  product.productName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Chip(
                  label: Text("${product.stock}"),
                  backgroundColor:
                      const Color.fromARGB(255, 239, 239, 255).withOpacity(0.1),
                ),
              ),
              children: [
                Consumer<DashboardControllerCssdCussDeptUser>(
                    builder: (context, dashboardConsumer, child) {
                  return Form(
                    key: dashboardConsumer.quantityFormKeys[index],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Enter quantity :"),
                              spaceW(5),
                              Consumer<DashboardControllerCssdCussDeptUser>(
                                  builder: (context, dashboardConsumer, child) {
                                return CustomTextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: dashboardConsumer
                                      .quantityControllers[index],
                                  // focusNode: dashboardConsumer.qtyFieldFocus,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: (value) {
                                    final enteredValue =
                                        int.tryParse(value!) ?? 0;
                                    if (value.isEmpty || value == "") {
                                      return "Empty";
                                    } else if (enteredValue <= product.stock) {
                                      return null;
                                    } else {
                                      return "Quantity exceeds stock";
                                    }
                                  },
                                  textFieldSize: const Size(100, 50),
                                );
                              }),
                            ],
                          ),
                          ButtonWidget(
                            buttonLabel: "Add",
                            onPressed: () {
                              if (controller
                                  .quantityFormKeys[index].currentState!
                                  .validate()) {
                                final usedItemsController =
                                    Provider.of<UsedItemEntryController>(
                                        context,
                                        listen: false);
                                usedItemsController
                                    .addToUsedItemsTableBeforeSubmit(
                                        context: context,
                                        productId: product.productId,
                                        productName: product.productName,
                                        location: selectedDepartment!,
                                        uQty: int.parse(dashboardConsumer
                                            .quantityControllers[index].text));
                                showPackageToast(
                                    text: "Added to used item list ",
                                    backgroundColor: Colors.green);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget makeDismissable({required Widget child}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
        final dashboardController =
            Provider.of<DashboardControllerCssdCussDeptUser>(context,
                listen: false);
        dashboardController.searchController.clear();
      },
      child: child,
    );
  }
}
