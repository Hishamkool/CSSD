import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/clickable_card.dart';
import 'package:cssd/Widgets/date_picker_widget.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/app/modules/Cssd_User/model/sampleRequestList.dart';
import 'package:cssd/app/modules/Cssd_User/controller/request_provider.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/requests_widgets/dropdown_search.dart';
import 'package:cssd/util/app_routes.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchRequestsViewCssdCussCssdLogin extends StatelessWidget {
  const SearchRequestsViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    // final isMobile = mediaQuery.width <= 500;
    final requestControler =
        Provider.of<RequestControler>(context, listen: false);

    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text('Search Requests', style: FontStyles.appBarTitleStyle),
      ),
      body: Container(
        height: double.infinity,
        width: mediaQuery.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.white),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // FromToDatePicker(
                //     fromDateController: requestControler.fromDateController,
                //     toDateController: requestControler.toDateController),

                SizedBox(height: 20.h),
                // select department and select user dropdowns
                Wrap(
                  runSpacing: 10,
                  spacing: 10,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatePickerWidget(
                        label: 'From Date',
                        controller: requestControler.fromDateController,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)),
                    DatePickerWidget(
                        label: 'To Date',
                        controller: requestControler.toDateController,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100)),
                    SizedBox(
                      width: mediaQuery.width * 0.40,
                      child: DropdownMenu(
                        inputDecorationTheme: InputDecorationTheme(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        width: mediaQuery.width / 2.5,
                        label: const Text("Select Deparment"),
                        controller: requestControler.departmentTextController,
                        enableSearch: false,
                        enableFilter: false,
                        dropdownMenuEntries:
                            requestControler.dropdownMenuEntries,
                      ),
                    ),
                    DropDownWithSearchFiltering(
                        mediaQuery: mediaQuery,
                        requestControler: requestControler),
                    ButtonWidget(
                      borderRadius: 12,
                      buttonLabel: 'Show',
                      onPressed: () {},
                    ),
                  ],
                ),

                // SizedBox(height: 10.h),
              ],
            ),
            Expanded(
              // height: mediaQuery.height / 2, // Set a finite height
              child: ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.w),
                shrinkWrap: true,
                itemCount:
                    sampleHighPriorityRequestsList.length, //change later on
                itemBuilder: (context, index) {
                  final request = sampleHighPriorityRequestsList[index];
                  return sampleHighPriorityRequestsList.isEmpty
                      ? null
                      : ClickableCard(
                          cardClickFunction: () {
                            Navigator.pushNamed(context,
                                Routes.requestDetailsViewCssdCussCssLogin);
                            if (kDebugMode) {
                              print("Card clicked");
                            }
                          },
                          cardColor: Colors.white,
                          requestID: request.requestID,
                          requestTitle: request.requestTitle,
                          requestDate: request.requestDate,
                          reqiestTime: request.requestTime,
                          requestDepartment: request.requestDepartment,
                          requestSubTitle: request.requestSubTitle,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
