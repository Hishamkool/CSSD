import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/endDrawer.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
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
      final requestId = ModalRoute.of(context)?.settings.arguments as List;
      context.read<RequestControler>().getCssdRequestListDetails(requestId[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final requestId = ModalRoute.of(context)!.settings.arguments as List;

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
              backgroundColor: StaticColors.scaffoldBackgroundcolor,
              onPressed: () {},
              label: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            FloatingActionButton.extended(
              backgroundColor: StaticColors.scaffoldBackgroundcolor,
              onPressed: () {},
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
              shrinkWrap: true,
              children: [
                //request title
                Consumer<RequestControler>(
                    builder: (context, requestsConsumer, child) {
                  final requestDetailsList =
                      requestsConsumer.requestDetailsDataList.first;
                  final requestedTime = requestDetailsList.rTime;
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
                              "Request ID :  ${requestId[0]}",
                              style: FontStyles.bodyPieTitleStyle,
                            ),
                            Text("Priority :  ${requestDetailsList.priority}"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Department : ${requestDetailsList.sub}"),
                            Text("$formatedDate "),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Requested By :  ${requestDetailsList.ruser}"),
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
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
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
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
