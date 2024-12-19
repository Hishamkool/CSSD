import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/endDrawer.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestDetailsViewCssdCussCssLogin extends StatelessWidget {
  
  const RequestDetailsViewCssdCussCssLogin({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: Column(
              children: [
                //request title
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Request ID :  4",
                          style: FontStyles.bodyPieTitleStyle,
                        ),
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
                ),
          
                //remarks expanded tile
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text(
                      "Remarks",
                      style: FontStyles.bodyPieTitleStyle,
                    ),
                    children: const [
                      Text("Please  sterilize  before 4pm today ."),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
          
                //items list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Items",
                        style: FontStyles.bodyPieTitleStyle,
                      ),
                      ButtonWidget(
                        borderRadius: 5,
                        buttonSize: const Size(0, 0),
                        buttonLabel: "Select All",
                        buttonTextSize: 16,
                        onPressed: () {
                          // function to select all items
                        },
                      )
                    ],
                  ),
                ),
          
                //single items cards
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Single Items",
                        style: FontStyles.bodyPieTitleStyle,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(255, 230, 245, 255),
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      mainAxisExtent: 130,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              itemCount: singleItemsList.length,
                              itemBuilder: (context, index) {
                                final singleItems = singleItemsList[index];
          
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
                                                singleItems,
                                                overflow:
                                                    TextOverflow.visible,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Checkbox(
                                              value: true,
                                              onChanged: (value) {},
                                            ),
                                          ],
                                        ),
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Card(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text("Qty : 1 "),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Packaged Items",
                        style: FontStyles.bodyPieTitleStyle,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: const Color.fromARGB(255, 230, 245, 255),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: sampleHighPriorityRequestsList.length,
                            itemBuilder: (context, index) {
                              final sampleRequest =
                                  sampleHighPriorityRequestsList[index];
          
                              return Card(
                                color: Colors.white,
                                child: ExpansionTile(
                                  title: Text(
                                    sampleRequest.requestTitle,
                                    overflow: TextOverflow.visible,
                                  ),
                                  subtitle: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
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
                                  children: [
                                    SizedBox(
                                        height: 100,
                                        child:
                                            ItemsListCardContainerWidget()),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
