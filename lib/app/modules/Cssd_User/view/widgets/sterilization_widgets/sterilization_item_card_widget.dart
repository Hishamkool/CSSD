import 'package:cssd/Widgets/button_widget.dart';
import 'package:cssd/util/colors.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SterilizationItemsCardWidget extends StatelessWidget {
  const SterilizationItemsCardWidget({
    super.key,
  });

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
                const Text("  Item name"),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID : 45 "),
                        Text("Dept: Operation theator"),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity : 4 "),
                        Text("Batch Number : 100152"),
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
