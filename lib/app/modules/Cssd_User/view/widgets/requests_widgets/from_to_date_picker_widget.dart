import 'package:flutter/material.dart';

class FromToDatePicker extends StatelessWidget {
  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final String fromLabel;
  final String toLabel;
  final double fieldWidth;

  const FromToDatePicker({
    Key? key,
    required this.fromDateController,
    required this.toDateController,
    this.fromLabel = "From",
    this.toLabel = "To",
    this.fieldWidth = 160.0, // Adjust field width if necessary
  }) : super(key: key);

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller,
      {DateTime? lastDate}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1998),
      initialDate: DateTime.now(),
      lastDate: lastDate ?? DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                fromLabel,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700), // Custom style
              ),
            ),
            SizedBox(
              width: fieldWidth,
              child: TextFormField(
                onTap: () => _selectDate(context, fromDateController),
                readOnly: true,
                controller: fromDateController,
                decoration: InputDecoration(
                  hintText: 'Day-Month-Year',
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                toLabel,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w700), // Custom style
              ),
            ),
            SizedBox(
              width: fieldWidth,
              child: TextFormField(
                onTap: () => _selectDate(context, toDateController,
                    lastDate: DateTime(2200)),
                readOnly: true,
                controller: toDateController,
                decoration: InputDecoration(
                  hintText: 'Day-Month-Year',
                  hintStyle: TextStyle(color: Colors.grey.shade300),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(15)),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
