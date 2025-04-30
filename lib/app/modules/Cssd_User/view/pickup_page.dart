import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/date_picker_widget.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/Widgets/rounded_container.dart';
import 'package:cssd/app/modules/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/Cssd_User/controller/pickup_provider.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PickupPageCssdCussCssdLogin extends StatelessWidget {
  const PickupPageCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    // final pickupProvider = Provider.of<PickupProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text('Pickup', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 10.0.h,
            ),
            // department selection dropdown

            //date picker and show button
            Consumer<PickupProvider>(builder: (context, pickupProvider, child) {
              return Wrap(
                runAlignment: WrapAlignment.end,
                runSpacing: 10,
                spacing: 10,
                children: [
                  DatePickerWidget(
                    label: "From",
                    controller: pickupProvider.fromDateTextController,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ),
                  DatePickerWidget(
                    label: "To",
                    controller: pickupProvider.toDateTextController,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  ),
                  SizedBox(
                    width: isMobile
                        ? mediaQuery.width * 0.40
                        : mediaQuery.width * 0.25,
                    child: DropdownMenu(
                      inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      width: 1.0.sw - 30,
                      menuHeight: 250,
                      label: const Text("Select Deparment"),
                      controller: pickupProvider.departmentSelection,
                      enableSearch: false,
                      enableFilter: false,
                      dropdownMenuEntries: pickupProvider.sampleDepartmentName
                          .map((dept) =>
                              DropdownMenuEntry(value: dept, label: dept))
                          .toList(),
                    ),
                  ),
                  ButtonWidget(
                    buttonLabel: "Show",
                    onPressed: () {},
                  )
                ],
              );
            }),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Request list",
                style: FontStyles.bodyPieTitleStyle,
              ),
            ),
            //searched request list
            SizedBox(
              height: mediaQuery.height * 0.35,
              child: RoundedContainer(
                  containerBody: Scrollbar(
                child: ListView.builder(
                  itemCount: sampleHighPriorityRequestsList.length,
                  itemBuilder: (context, index) {
                    final request = sampleHighPriorityRequestsList[index];

                    return ClickableCard(
                        cardColor: Colors.white,
                        requestID: request.requestID,
                        requestTitle: request.requestTitle,
                        requestDate: request.requestDate,
                        reqiestTime: "10.00",
                        requestDepartment: request.requestDepartment,
                        requestSubTitle: request.requestSubTitle);
                  },
                ),
              )),
            ),
            Text(
              "Items under the selected request",
              style: FontStyles.bodyPieTitleStyle,
            ),
            //items list
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: mediaQuery.height * 0.25),
              child: const ItemsListCardContainerWidget(),
            ),

            Center(
              child: ButtonWidget(
                buttonLabel: "Pickup",
                onPressed: () {},
              ),
            )
          ]),
        ),
      ),
    );
  }
}
