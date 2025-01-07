import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final DateTime firstDate;
  final DateTime initialDate;
  final DateTime lastDate;
  final double? maxWidth;

  const CustomDatePicker({
    Key? key,
    required this.controller,
    this.hintText = 'Day-Month-Year',
    this.label = 'dd-mm-yy',
    required this.firstDate,
    required this.initialDate,
    required this.lastDate,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        // Open date picker when tapped
        showDatePicker(
          context: context,
          firstDate: firstDate,
          initialDate: initialDate,
          lastDate: lastDate,
        ).then((pickedDate) {
          if (pickedDate != null) {
            // Format the picked date and update the controller
            String formattedDate = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
            controller.text = formattedDate;
          }
        });
      },
      readOnly: true, // Disable keyboard input
      controller: controller,
      decoration: InputDecoration(
        isDense: true, 
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade300),
        constraints: BoxConstraints(maxWidth: maxWidth ?? 1.sw / 2.5),
        focusedBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
         enabledBorder: OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: StaticColors.lightContainerborder),
          borderRadius: BorderRadius.circular(15),
        ),
        label: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(label),
            ],
          ),
        ),
        labelStyle: const  TextStyle(
          color: Colors.grey,  
        ),
      ),
    );
  }
}
