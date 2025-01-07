import 'package:cssd/Widgets/custom_textfield.dart';
import 'package:cssd/app/modules/Cssd_User/view/widgets/sterilization_widgets/sterilization_delete_button.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SterilizationItemsCardWidget extends StatelessWidget {
  const SterilizationItemsCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: hexToColorWithOpacity(hexColor: "EBF9FF"),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Item name : Item name"),
                PopupMenuButton(itemBuilder: (context) =>
                   <PopupMenuEntry> [
                    PopupMenuItem(child: const Text("Edit Quantity"),onTap: () {
                      
                    },),
                    PopupMenuItem(child: const  Text("Edit Batch Number"),onTap: () {
                      
                    },)
                  ]
                ,)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Expanded(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID : 45 "),
                      Text("Dept: Operation theator"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CustomTextFormField(
                            borderRadius: BorderRadius.circular(5),
                            textFieldSize: Size(0.35.sw, 20),
                            textfieldBorder: true,
                            label: const FittedBox(
                              child: Text(
                                'Enter batch no.',
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 9.0.h,
                          ),
                          CustomTextFormField(
                            borderRadius: BorderRadius.circular(5),
                            textFieldSize: Size(0.35.sw, 20),
                            textfieldBorder: true,
                            label: const FittedBox(
                              child: Text(
                                'Enter quantity',
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      
                      
                    ],
                  ),
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
