import 'package:cssd/app/modules/Cssd_User/model/sterilization_models/get_accepted_items_list_model.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SterilizationItemsCardWidget extends StatelessWidget {
  const SterilizationItemsCardWidget({
    super.key,
    required this.item,
  });
  final GetAcceptedItemListData item;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.white,
      backgroundColor: StaticColors.scaffoldBackgroundcolor,
    ));
    return Card(
      color: hexToColorWithOpacity(hexColor: "EBF9FF"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.productName),
                const Spacer(),
                PopupMenuButton(
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      color: StaticColors
                          .scaffoldBackgroundcolor, // background color
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 5.0),
                    child: const Row(
                      children: [
                        Icon(
                          FluentIcons.edit_12_filled,
                          size: 10,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          "Edit",
                          style: TextStyle(color: Colors.white), // text color
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text("Edit Quantity"),
                      onTap: () {},
                    ),
                    PopupMenuItem(
                      child: const Text("Edit Batch Number"),
                      onTap: () {},
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Product Id : ${item.productId} "),
                        Text("From Request : ${item.sid} "),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity : ${item.qty}  "),
                        const Text("Batch Number : test  "),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5.0.h,
            ),
          ],
        ),
      ),
    );
  }
}
