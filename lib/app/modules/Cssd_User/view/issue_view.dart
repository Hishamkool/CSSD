import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/Cssd_User/view/endDrawer.dart';
import 'package:cssd/app/modules/Cssd_User/model/sampleDropDownMenuEntries.dart';
import 'package:cssd/Widgets/dropdown_menu_widget.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/pickup_widgets/items_list_card_container_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueViewCssdCussCssdLogin extends StatelessWidget {
  const IssueViewCssdCussCssdLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
      endDrawer: endDrawer(context),
      appBar: AppBar(
        title: Text('Issue', style: FontStyles.appBarTitleStyle),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          // height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.0.h),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white),
          child: Column(
            children: [
              Wrap(
                runSpacing: 10,
                spacing: 10,
                children: [
                  CustomDropDownMenuWidget(
                      dropdownMenuEntries: sampleSterilizableItemsEntries,
                      onSelected: (selectedValue) {
                        if (kDebugMode) {
                          print(selectedValue);
                        }
                      },
                      label: 'Item name'),
                  SizedBox(
                    width: mediaQuery.width / 4,
                    // height: 100,
                    child: const CustomTextFormField(
                      textfieldBorder: true,
                      label: Text("Quantity"),
                    ),
                  ),
                  CustomDropDownMenuWidget(
                    dropdownMenuEntries: sampleUsersDropDownEntries,
                    onSelected: (selectedValue) {
                      if (kDebugMode) {
                        print(selectedValue);
                      }
                    },
                    label: 'Issued User',
                  ),
                  ButtonWidget(
                    buttonLabel: "Show",
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Items for issue",
                    style: FontStyles.bodyPieTitleStyle,
                  )),
              SizedBox(
                height: 10.h,
              ),
              const Expanded(child: ItemsListCardContainerWidget()),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    buttonLabel: "Issue",
                    onPressed: () {},
                  )
                ],
              )
            ],
          )),
    );
  }
}
