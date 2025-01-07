import 'package:cssd/app/modules/Cssd_User/controller/request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DropDownWithSearchFiltering extends StatelessWidget {
  final GlobalKey textFieldKey = GlobalKey();
  DropDownWithSearchFiltering({
    super.key,
    required this.mediaQuery,
    required this.requestControler,
  });

  final Size mediaQuery;
  final RequestControler requestControler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: mediaQuery.width * 0.40,
      //textfield and dropdown menu combined
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: TextFormField(
              key: textFieldKey,
              readOnly: false,
              controller: requestControler.requestedUserTextController,
              onChanged: (changeTextValue) {
                requestControler.filterUsers(changeTextValue);
                //to show dropdown
                requestControler.updateShowDropdown(true);
              },
              onFieldSubmitted: (value) {
                requestControler.updateShowDropdown(false);
                if (requestControler.filteredRequestedUsers.isNotEmpty) {
                  final RenderBox renderBox = textFieldKey.currentContext!
                      .findRenderObject() as RenderBox;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  final Size renderSize = renderBox.size;
                  showMenu(
                    context: context,
                    // position: RelativeRect.fromLTRB(0.7.sw, 320, 0.3.sw, 100),
                    position: RelativeRect.fromLTRB(
                      offset.dx, // X position of TextFormField
                      offset.dy +
                          renderSize
                              .height, // Y position + height to show below
                      offset.dx + renderSize.width, // Right boundary
                      offset.dy +
                          renderSize
                              .height, // Bottom boundary (adjust as needed)
                    ),
                    items: requestControler.filteredRequestedUsers
                        .map((String user) {
                      return PopupMenuItem<String>(
                        value: user,
                        child: Text(user),
                      );
                    }).toList(),
                  ).then((value) {
                    if (value != null) {
                      requestControler.updateSelectedUser(value);
                      requestControler.requestedUserTextController.text = value;
                    }
                  });
                }
              },
              decoration: InputDecoration(
                constraints: BoxConstraints(maxWidth: mediaQuery.width * 0.25),
                border: InputBorder.none,
                hintText: 'Enter to search',
                label: const Text("Requested User"),
                hintStyle: TextStyle(color: Colors.grey.shade300),
              ),
            ),
          ),
          SizedBox(width: 5.0.w),
          Consumer<RequestControler>(
              builder: (context, requestControler, child) {
            return DropdownButtonHideUnderline(
              child: SizedBox(
                width: 24,
                child: DropdownButton<String>(
                  isExpanded: true,
                  isDense: true,
                  iconDisabledColor: Colors.red,
                  menuWidth: 130.w,
                  // menuMaxHeight: 200.h,
                  items: requestControler.filteredRequestedUsers
                      .map((String user) {
                    return DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // if (value != null) {
                    //   requestControler.requestedUserTextController.text =
                    //       value;
                    // }
                    requestControler
                        .updateSelectedUser(value); // set selected user
                    requestControler.requestedUserTextController.text =
                        value ?? '';
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
