import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final DateTime firstDate;
  final DateTime initialDate;
  final DateTime lastDate;
  final double? maxWidth;

  const CustomDatePicker({
    super.key,
    required this.controller,
    this.hintText = 'Day-Month-Year',
    this.label = 'dd-mm-yy',
    required this.firstDate,
    required this.initialDate,
    required this.lastDate,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: mediaQuery.width / 2.5),
      child: TextFormField(
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
              String formattedDate =
                  "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";

              showTimePicker(context: context, initialTime: TimeOfDay.now())
                  .then((pickedTime) {
                if (pickedTime != null) {
                  final now = DateTime.now();
                  final dateTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  // Format the picked time using intl
                  String formattedTime = DateFormat.jm().format(dateTime);
                  // String formatedTime = "${pickedTime.hour}:${pickedTime.minute}";
                  controller.text = "$formattedDate $formattedTime";
                }
              });
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
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: StaticColors.lightContainerborder),
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
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
