import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_date_picker_widget.dart';
import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/Widgets/typehead_dropdown_search.dart';
import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_accepted_items_list_model.dart';
import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_process_name_model.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/Cssd_User/controller/sterilization_provider.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/sterilization_widgets/sterilization_item_card_widget.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/sterilization_widgets/sterilization_package_items_popup_widget.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/sterilization_widgets/sterilization_single_items_popup_widget%20.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SterilizationViewCssdCussCssdLogin extends StatefulWidget {
  const SterilizationViewCssdCussCssdLogin({super.key});

  @override
  State<SterilizationViewCssdCussCssdLogin> createState() =>
      _SterilizationViewCssdCussCssdLoginState();
}

class _SterilizationViewCssdCussCssdLoginState
    extends State<SterilizationViewCssdCussCssdLogin> {
  @override
  void initState() {
    super.initState();
    context.read<SterilizationProvider>().getMachineNames();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final requestId = ModalRoute.of(context)?.settings.arguments;
      if (requestId is int) {
        context.read<RequestControler>().getCssdRequestListDetails(requestId);
      }
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final sterilizationController =
        Provider.of<SterilizationProvider>(context, listen: false);
    final requestId = ModalRoute.of(context)?.settings.arguments;

    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text('Sterilize', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              child: ListView(
                children: [
                  Visibility(
                    visible: requestId != null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: RoundedContainer(containerBody:
                          Consumer<RequestControler>(
                              builder: (context, requestConsumer, child) {
                        final requestDetails =
                            requestConsumer.requestDetailsDataList.first;
                        final requestedTime = requestDetails.rTime;
                        // String formatedTime = DateFormat('hh:mm a').format(requestedTime);
                        String formatedDate =
                            DateFormat('dd/MMM/yyy').format(requestedTime);
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Request ID :  $requestId",
                                  style: FontStyles.bodyPieTitleStyle,
                                ),
                                ButtonWidget(
                                  borderRadius: 6,
                                  buttonSize: const Size(0, 0),
                                  buttonLabel: "Items",
                                  onPressed: () {
                                    customDialog(
                                      dialogContext: context,
                                      onCancelDefaultAction: () {
                                        Navigator.of(context).pop();
                                      },
                                      defaultAcceptText: "Add",
                                      defaultCancelText: "Cancel",
                                      dialogContent: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Single items :"),
                                            Expanded(
                                                child:
                                                    SterilizationSingleItemsPopupWidget()),
                                            SizedBox(height: 20),
                                            Text("Package Items :"),
                                            Expanded(
                                                child:
                                                    SterilizationPackageItemsPopupWidget()),
                                          ],
                                        ),
                                      ),
                                      dialogShowDefaultActions: true,
                                    );
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Department : ${requestDetails.sub}"),
                                Text("Priority : ${requestDetails.priority}"),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Requested By : ${requestDetails.ruser}"),
                                Text(formatedDate),
                              ],
                            ),
                          ],
                        );
                      })),
                    ),
                  ),
                  //insert textfields
                  Container(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Consumer<SterilizationProvider>(builder:
                                  (context, sterilizationConsumer, child) {
                                return FormField(
                                  builder: (field) {
                                    return InputDecorator(
                                      decoration: const InputDecoration(
                                          label: Text("Machine name"),
                                          border: InputBorder.none),
                                      child: CustomDropdown(
                                        validator: (machine) {
                                          if (machine == null) {
                                            return "Please choose a machine";
                                          }
                                          return null;
                                        },
                                        closedHeaderPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 11.0,
                                                horizontal: 10.0),
                                        onChanged: (value) {
                                          if (value != null) {
                                            sterilizationConsumer
                                                .updateSelectedMachine(value);
                                          } else {
                                            showPackageToast(
                                                backgroundColor: Colors.red,
                                                text: "Selected value is null");
                                          }
                                        },
                                        items: sterilizationConsumer
                                            .getmachinesList
                                            .map((item) => item.machineName)
                                            .toList(),
                                        hintText: "Machine name",
                                        decoration: CustomDropdownDecoration(
                                          expandedBorder: Border.all(
                                              color: Colors.grey.shade200),
                                          closedBorder: Border.all(
                                              color: const Color(0xffE7E7E7)),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Consumer<SterilizationProvider>(builder:
                                  (context, sterilizationConsumer, child) {
                                return DynamicSearchField<GetProcessNameData>(
                                  labelText: "Process name",
                                  clearDetails: () {},
                                  hintText: "Search process name",
                                  controller: sterilizationConsumer
                                      .processNameController,
                                  suggestionsCallback: (query) async {
                                    if (query.isNotEmpty) {
                                      return await sterilizationConsumer
                                          .getProcessName(query);
                                    } else {
                                      return [];
                                    }
                                  },
                                  itemBuilder: (context, product) {
                                    return ListTile(
                                      dense: true,
                                      title: Text(product.processName),
                                      subtitle: Text(
                                          "pressuer : ${product.pressure} "),
                                    );
                                  },
                                  onSelected: (process) {
                                    sterilizationConsumer.processNameController
                                        .text = process.processName;
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                    label: Text("Search items"),
                                    border: InputBorder.none),
                                child: CustomDropdown.searchRequest(
                                  validator: (selectedItem) {
                                    if (selectedItem == null ||
                                        selectedItem.productName.isEmpty) {
                                      return "Please choose an item";
                                    }
                                    return null;
                                  },
                                  headerBuilder:
                                      (context, selectedItem, enabled) {
                                    return Text(selectedItem.productName);
                                  },
                                  closedHeaderPadding:
                                      const EdgeInsets.symmetric(
                                          vertical: 11.0, horizontal: 10.0),
                                  decoration: CustomDropdownDecoration(
                                    closedBorder: Border.all(
                                        color:
                                            StaticColors.lightContainerborder),
                                  ),
                                  hintText: "Items",
                                  listItemBuilder: (context, item, isSelected,
                                      onItemSelect) {
                                    return ListTile(
                                      title: Text(
                                        item.productName,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Quantity : ${item.qty}"),
                                          Text("Request id : ${item.sid}"),
                                        ],
                                      ),
                                    );
                                  },
                                  searchHintText: "Search items",
                                  futureRequestDelay:
                                      const Duration(milliseconds: 0),
                                  futureRequest: (String searchQuerry) async {
                                    return await sterilizationController
                                        .getItemsForSterilization(searchQuerry);
                                  },
                                  onChanged: (selectedItemModel) {
                                    if (selectedItemModel != null) {
                                      sterilizationController
                                              .setSelectedAcceptedItemsModel =
                                          selectedItemModel;

                                      // setting default quantity in textfield
                                      sterilizationController
                                              .quantityController.text =
                                          selectedItemModel.qty.toString();
                                    } else {
                                      if (kDebugMode) {
                                        log("Selected items is null, so not updatind the selected items model and also not setting value in quantity controller");
                                      }
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          //Quantity and Batch number
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                    label: Text("Quantity"),
                                    border: InputBorder.none),
                                child: CustomTextFormField(
                                  textFieldSize: const Size(80.0, 80.0),
                                  controller: sterilizationController
                                      .quantityController,
                                  //label: Text("Quantity"),
                                  validator: (quantity) {
                                    if (quantity!.isEmpty || quantity == "") {
                                      return "Enter quantity";
                                    } else if (sterilizationController
                                            .selectedAcceptedItemModel ==
                                        null) {
                                      return "Item not selected";
                                    } else if (int.parse(quantity) >
                                        sterilizationController
                                            .selectedAcceptedItemModel!.qty) {
                                      showPackageToast(
                                          backgroundColor: Colors.red,
                                          text:
                                              "Quantity greater than available in selected request id ${sterilizationController.selectedAcceptedItemModel!.sid}");
                                      return "Exceeds limit";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                    label: Text("Batch number"),
                                    border: InputBorder.none),
                                child: CustomTextFormField(
                                  controller: sterilizationController
                                      .batchNumberController,
                                  keyboardType: TextInputType.number,
                                  label: const Text("Batch number"),
                                  textFieldSize: const Size(80.0, 80.0),
                                  validator: (batch) {
                                    if (batch == null || batch == "") {
                                      return "Bach number empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ButtonWidget(
                                  useFitterBox: true,
                                  borderRadius: 10,
                                  buttonLabel: isMobile ? 'Add' : 'Add to list',
                                  onPressed: () {
                                    // Add item to the list
                                    if (_formKey.currentState!.validate()) {
                                      if (sterilizationController
                                              .selectedAcceptedItemModel !=
                                          null) {
                                        sterilizationController
                                            .addAcceptedItemsToList(
                                                sterilizationController
                                                    .selectedAcceptedItemModel!);
                                      } else {
                                        showPackageToast(
                                            backgroundColor: Colors.red,
                                            text: "Item model not selected ");
                                      }
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: Consumer<SterilizationProvider>(
                          builder: (context, sterilizationProvider, child) {
                        return Card(
                          shadowColor: Colors.transparent,
                          color: Colors.white,
                          child: ExpansionTile(
                            onExpansionChanged: (value) {
                              sterilizationProvider
                                  .updateExpansionTileStatus(value);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            initiallyExpanded: true,
                            title: sterilizationProvider
                                        .expansionTileExpanded ==
                                    true
                                ? Text(
                                    "Hide Added Items (${sterilizationProvider.addedAcceptedItemsList.length})",
                                    style: FontStyles.bodyPieTitleStyle,
                                  )
                                : Text(
                                    "Show Added Items (${sterilizationProvider.addedAcceptedItemsList.length})",
                                    style: FontStyles.bodyPieTitleStyle),
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: sterilizationProvider
                                    .addedAcceptedItemsList.length,
                                itemBuilder: (context, index) {
                                  List<GetAcceptedItemListData> item =
                                      sterilizationProvider
                                          .addedAcceptedItemsList;
                                  return Column(
                                    children: [
                                      Dismissible(
                                        behavior: HitTestBehavior.deferToChild,
                                        key: ValueKey(item[index]),
                                        background: Container(
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          color: Colors.red,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                FluentIcons.delete_12_filled,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        secondaryBackground: Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          color: Colors.red,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                FluentIcons.delete_12_filled,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        direction: DismissDirection.horizontal,
                                        child: SterilizationItemsCardWidget(
                                          item: item[index],
                                        ),
                                        onDismissed: (direction) {
                                          sterilizationProvider
                                              .deleteAddedAccepedItemsList(
                                                  index);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<SterilizationProvider>(builder:
                                (context, sterilizationController, child) {
                              return CustomDatePicker(
                                  controller: sterilizationController
                                      .startTimeController,
                                  firstDate: DateTime(1900),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  hintText: 'dd-mm-yy',
                                  label: "Start Time",
                                  maxWidth: 1.sw / 2.5);
                            }),
                          ],
                        ),
                      ),
                      Consumer<SterilizationProvider>(
                          builder: (context, sterilizationController, child) {
                        return CustomDatePicker(
                            controller:
                                sterilizationController.endTimeController,
                            firstDate: DateTime(1900),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            hintText: 'dd-mm-yy',
                            label: "End Time",
                            maxWidth: 1.sw / 2.5);
                      })
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWidget(
                        buttonLabel: 'Cancel',
                        onPressed: () {},
                      ),
                      ButtonWidget(buttonLabel: 'Sterilize', onPressed: () {})
                    ],
                  ),
                  SizedBox(
                    height: 10.0.h,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
