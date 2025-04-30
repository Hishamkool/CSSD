import 'dart:developer';

import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/app/modules/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/app/modules/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
import 'package:cssd/main.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RequestDetailsViewCssdCussCssLogin extends StatefulWidget {
  const RequestDetailsViewCssdCussCssLogin({
    super.key,
  });

  @override
  State<RequestDetailsViewCssdCussCssLogin> createState() =>
      _RequestDetailsViewCssdCussCssLoginState();
}

class _RequestDetailsViewCssdCussCssLoginState
    extends State<RequestDetailsViewCssdCussCssLogin> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final requestId = ModalRoute.of(context)?.settings.arguments as int;
      context.read<RequestControler>().getCssdRequestListDetails(requestId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
        backgroundColor: StaticColors.scaffoldBackgroundcolor,
        endDrawer: endDrawer(context),
        appBar: AppBar(
          title: Text('Requests Details', style: FontStyles.appBarTitleStyle),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                buttonColor: hexToColorWithOpacity(hexColor: "047F76"),
                buttonLabel: "Timeline",
                onPressed: () {},
                buttonPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context)
                        .openEndDrawer(); // Opens the end drawer
                  },
                );
              },
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              heroTag: "cancelRequest",
              backgroundColor: StaticColors.scaffoldBackgroundcolor,
              onPressed: () {
                Navigator.pop(context);
              },
              label: const Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton.extended(
              heroTag: "acceptRequest",
              backgroundColor: StaticColors.scaffoldBackgroundcolor,
              onPressed: () async {
                final requestController =
                    Provider.of<RequestControler>(context, listen: false);
                bool ifAccepted =
                    await requestController.acceptCurrentRequest(requestId);

                if (ifAccepted) {
                  navigatorKey.currentState!.pushNamed(
                      Routes.sterilizationViewCssdCussCssdLogin,
                      arguments: requestId);
                }
              },
              label: const Text(
                "Accept",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(0xffF0F5FA)),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: ListView(
              shrinkWrap: false,
              children: [
                //request title
                Consumer<RequestControler>(
                    builder: (context, requestConsumer, child) {
                  // load data if list is not empty
                  if (requestConsumer.requestDetailsDataList.isNotEmpty) {
                    final requestDetails =
                        requestConsumer.requestDetailsDataList.first;
                    final requestedTime = requestDetails.rTime;
                    String formatedTime =
                        DateFormat('hh:mm a').format(requestedTime);
                    String formatedDate =
                        DateFormat('dd/MMM/yyy').format(requestedTime);
                    return RoundedContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      containerBody: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Request ID :  $requestId",
                                style: FontStyles.bodyPieTitleStyle,
                              ),
                              Text("Priority :  ${requestDetails.priority}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Department : ${requestDetails.sub}"),
                              Text("$formatedDate "),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Requested By :  ${requestDetails.ruser}"),
                              Text("$formatedTime "),
                            ],
                          ),
                          //remarks expanded tile
                          ExpansionTile(
                            shape: Border.all(color: Colors.transparent),
                            tilePadding: const EdgeInsets.all(0.0),
                            title: Text(
                              "Remarks",
                              style: FontStyles.bodyPieTitleStyle,
                              textAlign: TextAlign.left,
                            ),
                            expandedCrossAxisAlignment:
                                CrossAxisAlignment.start,
                            expandedAlignment: Alignment.centerLeft,
                            childrenPadding: const EdgeInsets.only(left: 20.0),
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              Consumer<RequestControler>(
                                  builder: (context, requestsConsumer, child) {
                                return Text(requestsConsumer
                                    .requestDetailsDataList.first.remarks);
                              })
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox(
                      height: 140,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }),

                //items list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: hexToColorWithOpacity(hexColor: "1C170D")),
                      ),
                      ButtonWidget(
                        /* borderRadius: 10, */
                        /* buttonSize: const Size(0, 0), */
                        buttonLabel: "Select All",
                        buttonTextSize: 16,
                        onPressed: () {
                          // function to select all items
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                //single items cards
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Single Items",
                      style: FontStyles.bodyPieTitleStyle,
                    ),
                    Consumer<RequestControler>(
                        builder: (context, requestsConsumer, child) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              requestsConsumer.requestDetailsDataList.length,
                          itemBuilder: (context, index) {
                            final singleItems =
                                requestsConsumer.requestDetailsDataList[index];

                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            singleItems.productName,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Checkbox(
                                          value: context
                                              .read<RequestControler>()
                                              .isChecked,
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Card(
                                          color: const Color(0xffF0F5FA),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Qty : ${singleItems.qty} "),
                                          ),
                                        ),
                                        Card(
                                          color: const Color(0xffF0F5FA),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                "Product ID : ${singleItems.productId} "),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }),

                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Packages",
                      style: FontStyles.bodyPieTitleStyle,
                    ),

                    // when package items are included handle the visibility accordingly -- not using packages right now.
                    Visibility(
                      replacement: const Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text("No package items"),
                      )),
                      visible: false,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sampleHighPriorityRequestsList.length,
                          itemBuilder: (context, index) {
                            final sampleRequest =
                                sampleHighPriorityRequestsList[index];

                            return Card(
                              color: Colors.white,
                              child: ExpansionTile(
                                shape: Border.all(color: Colors.transparent),
                                title: Text(
                                  sampleRequest.requestTitle,
                                  overflow: TextOverflow.visible,
                                ),
                                subtitle: const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("tems : 1 "),
                                      ),
                                    ),
                                  ],
                                ),
                                children: const [
                                  ItemsListCardContainerWidget(),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
