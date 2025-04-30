import 'package:flutter/material.dart';
/* usage 
final provider = Provider.of<>(context,listen:false); // select the provider <>

DatePickerField(
          label: "From", 
          controller: pickupProvider.fromDateTextController,
          firstDate: DateTime(1998), // Set the first valid date
          lastDate: DateTime.now(),  // Set the last valid date
        ),

        */

class DatePickerWidget extends StatelessWidget {
  final String label; // "From" or "To"
  final TextEditingController controller; // Controller for the text field
  final DateTime firstDate;
  final DateTime lastDate;

  const DatePickerWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final Size mediaQuery = MediaQuery.of(context).size;
    final isMobile = mediaQuery.width <= 500;
    return SizedBox(
      width: isMobile ? mediaQuery.width * 0.40 : mediaQuery.width * 0.25,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(3.0),
          //   child: Text(
          //     label, // Use the passed label (e.g., "From" or "To")
          //     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //   ),
          // ),
          TextFormField(
            onTap: () {
              showDatePicker(
                context: context,
                firstDate: firstDate,
                initialDate: DateTime.now(),
                lastDate: lastDate,
              ).then((pickedDate) {
                if (pickedDate != null) {
                  String formattedDate =
                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                  controller.text = formattedDate;
                }
              });
            },
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              label: Text(label),
              hintText: 'Day-Month-Year',
              prefixIcon: const Icon(Icons.date_range),
              hintStyle: TextStyle(color: Colors.grey.shade300),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}









/* Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "From",
                              style: FontStyles.bodyPieTitleStyle,
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1998),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime.now())
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  String formatedDate =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  pickupProvider.fromDateTextController.text =
                                      formatedDate;
                                }
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: pickupProvider.fromDateTextController,
                            decoration: InputDecoration(
                              hintText: 'Day-Month-Year',
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              constraints: BoxConstraints(maxWidth: 100.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "To",
                              style: FontStyles.bodyPieTitleStyle,
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1998),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(2200))
                                  .then((pickedDate) {
                                if (pickedDate != null) {
                                  String formatedDate =
                                      "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                                  pickupProvider.toDateTextController.text =
                                      formatedDate;
                                }
                              });
                            },
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            controller: pickupProvider.toDateTextController,
                            decoration: InputDecoration(
                              hintText: 'Day-Month-Year',
                              hintStyle: TextStyle(color: Colors.grey.shade300),
                              constraints: BoxConstraints(maxWidth: 100.w),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        ],
                      ),*/