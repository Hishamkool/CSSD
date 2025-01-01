import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_date_picker_widget.dart';
import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/endDrawer.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/sterilization_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/sterilization_widgets/sterilization_item_card_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/sterilization_widgets/sterilization_package_items_popup_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/sterilization_widgets/sterilization_single_items_popup_widget%20.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
    final requestId = ModalRoute.of(context)?.settings.arguments ;
      if (requestId  is int ) {
        context
            .read<RequestControler>()
            .getCssdRequestListDetails(requestId); // eg: , [11]
      }  
    });
  }

  @override
  Widget build(BuildContext context) {
    final  requestId = ModalRoute.of(context)?.settings.arguments ;
    
    final mediaQuery = MediaQuery.of(context).size;
    var isMobile = mediaQuery.width <= 500;
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text('Sterilize', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Visibility(
                    visible: requestId != null,
                    child: RoundedContainer(
                        containerBody: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonWidget(
                              borderRadius: 6,
                              buttonSize: const Size(0, 0),
                              buttonLabel: "change",
                              onPressed: () {},
                            ),
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
                                        MediaQuery.of(context).size.height * 0.5,
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
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
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Department : Operation Theater"),
                            Text("Priority : Medium"),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Requested By : Omar"),
                            Text("Request date : 21-10-2024"),
                          ],
                        ),
                      ],
                    )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        Row(
                          //machine and add machine
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Consumer<SterilizationProvider>(builder:
                                  (context, sterilizationController, child) {
                                return DropdownMenu(
                                  label: const Text("Machine"),
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  dropdownMenuEntries: sterilizationController
                                      .sterilizationMachines
                                      .map((machines) => DropdownMenuEntry(
                                          value: machines, label: machines))
                                      .toList(),
                                  onSelected: (String? value) {
                                    sterilizationController
                                        .updateSelectedMachine(value);
                                  },
                                );
                              }),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ButtonWidget(
                                borderRadius: 10,
                                // buttonSize: const Size(0, 0),
                                buttonPadding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 1.0),
                                buttonLabel: "Add machine",
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          //Process name and Item name
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Consumer<SterilizationProvider>(builder:
                                  (context, sterilizationController, child) {
                                return DropdownMenu(
                                  label: const Text("Process name"),
                                  inputDecorationTheme: InputDecorationTheme(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  dropdownMenuEntries: sterilizationController
                                      .sterilizationMachines
                                      .map((machines) => DropdownMenuEntry(
                                          value: machines, label: machines))
                                      .toList(),
                                  onSelected: (String? value) {
                                    sterilizationController
                                        .updateSelectedMachine(value);
                                  },
                                );
                              }),
                            ),
                            SizedBox(width: 10.w),
                            const Expanded(
                                child: CustomTextFormField(
                              textfieldBorder: true,
                              hintText: 'Enter to search',
                              labelText: 'Item name',
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          //Quantity and Batch number
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                label: Text("Quantity"),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: CustomTextFormField(
                                label: Text("Batch number"),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ButtonWidget(
                                useFitterBox: true,
                                borderRadius: 10,
                                buttonLabel: 'Add to list',
                                onPressed: () {
                                  // Add item to the list
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5.0),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: Consumer<SterilizationProvider>(
                          builder: (context, sterilizationProvider, child) {
                        return Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            onExpansionChanged: (value) {
                              sterilizationProvider
                                  .updateExpansionTileStatus(value);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            initiallyExpanded: true,
                            title:
                                sterilizationProvider.expansionTileExpanded ==
                                        true
                                    ? Text(
                                        "Hide Added Items",
                                        style: FontStyles.bodyPieTitleStyle,
                                      )
                                    : Text("Show Added Items",
                                        style: FontStyles.bodyPieTitleStyle),
                            children: [
                              RoundedContainer(
                                containerColor: Colors.white70,
                                containerHeight: 400,
                                containerBody: Scrollbar(
                                  child: ListView.builder(
                                    itemCount: 2,
                                    itemBuilder: (context, index) {
                                      return const Column(
                                        children: [
                                          SterilizationItemsCardWidget(),
                                          SterilizationItemsCardWidget(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
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
            ),
          )),
    );
  }
}
