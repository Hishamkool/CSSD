import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/bottom_sheet_divider_widget.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/app/modules/Department_User/controller/send_to_cssd_controller.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

List<DropdownMenuEntry<String>> priorityDropdownEntries = const [
  DropdownMenuEntry(
    value: "High",
    label: "High Priority",
  ),
  DropdownMenuEntry(
    value: "Medium",
    label: "Medium Priority",
  ),
  DropdownMenuEntry(
    value: "Low",
    label: "Low Priority",
  ),
];

class SendToCssdViewCssdCussDeptUser extends StatefulWidget {
  const SendToCssdViewCssdCussDeptUser({super.key});

  @override
  State<SendToCssdViewCssdCussDeptUser> createState() =>
      _SendToCssdViewCssdCussDeptUserState();
}

class _SendToCssdViewCssdCussDeptUserState
    extends State<SendToCssdViewCssdCussDeptUser> {
  @override
  void initState() {
    final selectedDepartment = context
        .read<DashboardControllerCssdCussDeptUser>()
        .getSelectedDepartment;
    context
        .read<SendToCssdControllerCssdCussDeptUser>()
        .fetchUsedItems(searchQuery: "", location: selectedDepartment);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    final sterilizationController =
        Provider.of<SendToCssdControllerCssdCussDeptUser>(context,
            listen: false);

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        title:
            Text('Sterilization Request', style: FontStyles.appBarTitleStyle),
        actions: [
          Tooltip(
            message: "List all used items",
            child: ButtonWidget(
              buttonLabel: "Used items",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 3,

                            //get used items dropdown
                            child:
                                Consumer<SendToCssdControllerCssdCussDeptUser>(
                                    // items search suggestions
                                    builder: (context, sterilizationConsumer,
                                        child) {
                              final dashboardController = Provider.of<
                                      DashboardControllerCssdCussDeptUser>(
                                  context,
                                  listen: false);

                              // fetching selected department from dashboard
                              String selectedDepartment =
                                  dashboardController.getSelectedDepartment;
                              return InputDecorator(
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    border: InputBorder.none,
                                    label: Text("Search items  ")),
                                child: CustomDropdown.searchRequest(
                                  onChanged: (selectedItemModel) {
                                    if (selectedItemModel != null) {
                                      log('currently selected item : ${selectedItemModel.productName}');
                                      sterilizationConsumer
                                              .setSelectedItemModel =
                                          selectedItemModel;
                                    } else {
                                      showPackageToast(
                                          backgroundColor: Colors.red,
                                          text: "selected item is null");
                                    }
                                  },
                                  futureRequestDelay:
                                      const Duration(milliseconds: 0),
                                  futureRequest: (stringItem) async {
                                    // api calling to get the item name
                                    if (selectedDepartment == "") {
                                      showPackageToast(
                                          backgroundColor: Colors.red,
                                          text:
                                              "Select department to search items");
                                    } else {
                                      await sterilizationConsumer
                                          .fetchUsedItems(
                                              searchQuery: stringItem,
                                              location: selectedDepartment);
                                    }
                                    // list of items for the search query
                                    return sterilizationConsumer
                                        .getUsedItemsListForSearch;
                                  },
                                  headerBuilder:
                                      (context, selectedItem, enabled) {
                                    if (sterilizationConsumer
                                            .getSelectedUsedItemModel
                                            ?.productName ==
                                        null) {
                                      // clear the header when itemmodel is null - set when department in changed from dropdown
                                      return const Text("");
                                    }
                                    log("item model is ${sterilizationConsumer.getSelectedUsedItemModel?.productName}");
                                    return Text(selectedItem.productName);
                                  },
                                  listItemBuilder: (context, item, isSelected,
                                          onItemSelect) =>
                                      ListTile(
                                    title: Text(item.productName),
                                    subtitle: Text(
                                      "used quantity : ${item.usedQty}",
                                    ),
                                  ),
                                  closedHeaderPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 11.0, horizontal: 10.0),
                                  decoration: CustomDropdownDecoration(
                                    closedBorder: Border.all(
                                        color:
                                            StaticColors.lightContainerborder),
                                  ),
                                  hintText: "Items",
                                  searchHintText: "Search used items",
                                  hideSelectedFieldWhenExpanded: false,
                                  validator: (item) {
                                    if (item == null) {
                                      return "Slection required";
                                    }
                                    return null;
                                  },
                                ),
                              );
                            })),
                        SizedBox(
                          width: 10.w,
                        ),

                        // quantity textfield
                        Flexible(child:
                            Consumer<SendToCssdControllerCssdCussDeptUser>(
                                builder:
                                    (context, sterilizationConsumer, child) {
                          return InputDecorator(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(0.0),
                                border: InputBorder.none,
                                label: Text("Quantity")),
                            child: CustomTextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter
                                    .digitsOnly, // Restricts input to digits only
                              ],
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              textFieldSize: const Size(double.infinity, 80.0),
                              label: const FittedBox(child: Text("Quantity")),
                              controller:
                                  sterilizationController.quantityController,
                              validator: (enteredQuantity) {
                                final avalilableQuantity = sterilizationConsumer
                                        .getSelectedUsedItemModel?.usedQty ??
                                    0;

                                if (enteredQuantity == null ||
                                    enteredQuantity.isEmpty) {
                                  showPackageToast(
                                      text: "Enter a valid number");
                                  return 'empty';
                                }

                                try {
                                  final quantity = int.parse(enteredQuantity);

                                  if (quantity <= 0) {
                                    showPackageToast(
                                        text: "Enter valid quantity");
                                    return 'negative / zero';
                                  }

                                  if (quantity > avalilableQuantity) {
                                    showPackageToast(
                                        backgroundColor: Colors.red,
                                        text:
                                            "Entered quantity exceeds available quantity : $avalilableQuantity");
                                    return 'Exceeds limit';
                                  }

                                  // Quantity is valid
                                  return null;
                                } catch (e) {
                                  log("quantity exception $e");
                                  showPackageToast(
                                      text: "Enter a valid number");

                                  return 'Enter a valid number ';
                                }
                              },
                            ),
                          );
                        })),
                      ],
                    ),
                    //add button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          buttonLabel: "Add",
                          onPressed: () {
                            final item = sterilizationController
                                .getSelectedUsedItemModel;
                            final quantity =
                                sterilizationController.quantityController.text;
                            if (item?.productName != null) {
                              if (_formKey.currentState!.validate()) {
                                sterilizationController.addItemsToGrid(
                                    item!, int.parse(quantity));
                                sterilizationController.clearInputsForAdd();
                              }
                            } else {
                              showPackageToast(
                                  backgroundColor: Colors.red,
                                  text: "Item is not selected");
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    //listing added items
                    Consumer<SendToCssdControllerCssdCussDeptUser>(
                        builder: (context, sterilizationConsumer, child) {
                      if (sterilizationConsumer
                          .getSelectedItemsQuantityList.isEmpty) {
                        return Center(
                          child: SvgPicture.asset(
                            "assets/svg/Checklist-rafiki.svg",
                            height: 250,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sterilizationConsumer
                            .getSelectedItemsQuantityList.length,
                        itemBuilder: (context, index) {
                          final item = sterilizationConsumer
                              .getSelectedItemsQuantityList[index];
                          return CupertinoContextMenu(
                            actions: [
                              CupertinoContextMenuAction(
                                onPressed: () {
                                  sterilizationConsumer
                                      .deleteCurrentItemFromList(item);
                                  Navigator.pop(context);
                                },
                                isDestructiveAction: true,
                                trailingIcon: CupertinoIcons.delete,
                                child: const Text("Delete"),
                              )
                            ],
                            enableHapticFeedback: true,
                            child: Card(
                              color: Colors.lightBlue.shade50,
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Item:',
                                              overflow: TextOverflow.visible,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 4.w,
                                            ),
                                            Text(item.productname)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Quantity:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(' ${item.qty}'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          sterilizationConsumer
                                              .deleteCurrentItemFromList(item);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
              ButtonWidget(
                buttonLabel: "Send To CSSD",
                onPressed: () {
                  showModalBottomSheet(
                    showDragHandle: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // const BottomSheetDivider(),
                              // number of items in list
                              Row(
                                children: [
                                  const Text("Types of items : "),
                                  Consumer<
                                          SendToCssdControllerCssdCussDeptUser>(
                                      builder: (context, sterilizationConsumer,
                                          child) {
                                    return Text(
                                      sterilizationConsumer
                                          .getSelectedItemsQuantityList.length
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.purple, fontSize: 25),
                                    );
                                  }),
                                ],
                              ),
                              spaceH(8),
                              //Priority radio button
                              Consumer<SendToCssdControllerCssdCussDeptUser>(
                                  builder:
                                      (context, sterilizationConsumer, child) {
                                return InputDecorator(
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      label: Text("Choose request priority")),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("High"),
                                          value: "High",
                                          groupValue:
                                              sterilizationConsumer.getPriority,
                                          onChanged: (priority) {
                                            if (priority != null) {
                                              sterilizationConsumer
                                                  .setPriority(priority);
                                            }
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          title: const Text("Medium"),
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          contentPadding: EdgeInsets.zero,
                                          value: "Medium",
                                          groupValue:
                                              sterilizationConsumer.getPriority,
                                          onChanged: (priority) {
                                            if (priority != null) {
                                              sterilizationConsumer
                                                  .setPriority(priority);
                                            }
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          visualDensity: const VisualDensity(
                                              horizontal: -4.0),
                                          contentPadding: EdgeInsets.zero,
                                          title: const Text("Low"),
                                          value: "Low",
                                          groupValue:
                                              sterilizationConsumer.getPriority,
                                          onChanged: (priority) {
                                            if (priority != null) {
                                              sterilizationConsumer
                                                  .setPriority(priority);
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                              //remarks container
                              InputDecorator(
                                decoration: const InputDecoration(
                                    label: Text("Remarks"),
                                    border: InputBorder.none),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: 600, maxHeight: 400),
                                  child: RoundedContainer(
                                    containerHeight: 100,
                                    containerBody: CustomTextFormField(
                                      minLines: 1,
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller: sterilizationController
                                          .remarksController,
                                      label: const Text("Remarks"),
                                      hintText: "Remarks for cssd user",
                                      hintStyle: const TextStyle(
                                          color: Colors.white24),
                                      textfieldBorder: false,
                                    ),
                                  ),
                                ),
                              ),
                              //send to cssd button / slider
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: SlideAction(
                                  // height: 50,
                                  sliderRotate: false,
                                  sliderButtonIcon: const Icon(
                                    FluentIcons.vehicle_truck_profile_16_filled,
                                    // size: 25,
                                    size: 29,
                                    color: StaticColors.scaffoldBackgroundcolor,
                                  ),
                                  outerColor:
                                      StaticColors.scaffoldBackgroundcolor,
                                  text: "Slide to send »",

                                  // sliderButtonIconPadding: 5,
                                  onSubmit: () {
                                    return sterilizationController
                                        .sendUsedItemsToCssd(dashboardController
                                            .getSelectedDepartment)
                                        .then((_) {
                                      sterilizationController.clearAllInputs();
                                      final dashboardController = Provider.of<
                                              DashboardControllerCssdCussDeptUser>(
                                          context,
                                          listen: false);
                                      final selectedDepartment =
                                          dashboardController
                                              .getSelectedDepartment;
                                      dashboardController
                                          .getPieChartData(selectedDepartment);
                                      dashboardController
                                          .fetchMyRequests(selectedDepartment);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ]),
          ),
        ),
      ),
    );
  }
}

/* //Priority radio button
              Consumer<SendToCssdControllerCssdCussDeptUser>(
                  builder: (context, sterilizationConsumer, child) {
                return InputDecorator(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Choose request priority")),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("High"),
                          value: "High",
                          groupValue: sterilizationConsumer.getPriority,
                          onChanged: (priority) {
                            if (priority != null) {
                              sterilizationConsumer.setPriority(priority);
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          title: const Text("Medium"),
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          contentPadding: EdgeInsets.zero,
                          value: "Medium",
                          groupValue: sterilizationConsumer.getPriority,
                          onChanged: (priority) {
                            if (priority != null) {
                              sterilizationConsumer.setPriority(priority);
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile(
                          visualDensity: const VisualDensity(horizontal: -4.0),
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Low"),
                          value: "Low",
                          groupValue: sterilizationConsumer.getPriority,
                          onChanged: (priority) {
                            if (priority != null) {
                              sterilizationConsumer.setPriority(priority);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                );
              }),
              //remarks container
              InputDecorator(
                decoration: const InputDecoration(
                    label: Text("Remarks"), border: InputBorder.none),
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: 600, maxHeight: 400),
                  child: RoundedContainer(
                    containerHeight: 100,
                    containerBody: CustomTextFormField(
                      minLines: 1,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: sterilizationController.remarksController,
                      label: const Text("Remarks"),
                      hintText: "Remarks for cssd user",
                      hintStyle: const TextStyle(color: Colors.white24),
                      textfieldBorder: false,
                    ),
                  ),
                ),
              ),
              //send to cssd button / slider
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: SlideAction(
                  height: 50,
                  sliderRotate: false,
                  sliderButtonIcon: const Icon(
                    FluentIcons.vehicle_truck_profile_16_filled,
                    size: 25,
                    color: StaticColors.scaffoldBackgroundcolor,
                  ),
                  outerColor: StaticColors.scaffoldBackgroundcolor,
                  text: "Slide to send to cssd ->",
                  sliderButtonIconPadding: 5,
                  onSubmit: () {
                    return sterilizationController
                        .sendUsedItemsToCssd(
                            dashboardController.getSelectedDepartment)
                        .then((_) {
                      sterilizationController.clearAllInputs();
                      final dashboardController =
                          Provider.of<DashboardControllerCssdCussDeptUser>(
                              context,
                              listen: false);
                      final selectedDepartment =
                          dashboardController.getSelectedDepartment;
                      dashboardController.getPieChartData(selectedDepartment);
                      dashboardController.fetchMyRequests(selectedDepartment);
                    });
                  },
                ),
              ), */

//send to cssd button
/* ButtonWidget(
              buttonLabel: "Send for Sterilization",
              onPressed: () {
          /*                   customDialog(
                  dialogContext: context,
                  dialogContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //remarks container
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                            maxWidth: 600, maxHeight: 400),
                        child: RoundedContainer(
                          containerHeight: mediaQuery.height / 7,
                          containerBody: CustomTextFormField(
                            minLines: 1,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller:
                                sterilizationController.remarksController,
                            label: const Text("Remarks"),
                            textfieldBorder: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onAcceptDefaultAction: () {
                    //api call
                    sterilizationController
                        .sendUsedItemsToCssd(
                            dashboardController.getSelectedDepartment)
                        .then((_) {
                      Navigator.pop(context);
                    });
                  },
                  onCancelDefaultAction: () {
                    Navigator.pop(context);
                  },
                ); */
              },
            ), */

//priority dropdown

/*  Consumer<SendToCssdControllerCssdCussDeptUser>(
                          builder: (context, sterilizationConsumer, child) {
                        return DropdownMenu(
                            initialSelection:
                                sterilizationConsumer.getPriority == ""
                                    ? null
                                    : sterilizationConsumer.getPriority,
                            menuHeight: 230,
                            label: const Text(
                              "Priority",
                              overflow: TextOverflow.fade,
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              fillColor: Colors.amber,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                            ),
                            dropdownMenuEntries: priorityDropdownEntries,
                            trailingIcon: const Padding(
                              padding: EdgeInsets.only(right: 0),
                              child: Icon(Icons.arrow_drop_down),
                            ),
                            onSelected: (priority) {
                              final defaultPriority =
                                  priorityDropdownEntries[1].value;
                              if (priority != null) {
                                sterilizationController.setPriority(priority);
                              } else {
                                sterilizationController
                                    .setPriority(defaultPriority);
                                log("priority null so default priority Medium is passed ");
                              }
                            });
                      }), */
