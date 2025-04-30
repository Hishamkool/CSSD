import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cssd/app/modules/Department_User/controller/dashboard_controller_dept.dart';
import 'package:cssd/util/app_util.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RequestDetailsViewCssdCussDeptUser extends StatefulWidget {
  const RequestDetailsViewCssdCussDeptUser({super.key});

  @override
  State<RequestDetailsViewCssdCussDeptUser> createState() =>
      _RequestDetailsViewCssdCussDeptUserState();
}

class _RequestDetailsViewCssdCussDeptUserState
    extends State<RequestDetailsViewCssdCussDeptUser> {
  late String? selectedDepartment;
  @override
  void initState() {
    super.initState();
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    selectedDepartment = dashboardController.getSelectedDepartment;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (selectedDepartment != null) {
        dashboardController.fetchRequestDetails(selectedDepartment!);
      } else {
        showPackageToast(backgroundColor:Colors.red, text: "Select Department");
      }
    });
  }

  static const List<String> _dropdownItemsDetails = [
    "All Request Details",
    "Pending Request deatails"
  ];

  @override
  Widget build(BuildContext context) {
    final dashboardController =
        Provider.of<DashboardControllerCssdCussDeptUser>(context,
            listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 90,
        title: Column(
          children: [
            CustomDropdown(
              initialItem: _dropdownItemsDetails.first,
              items: _dropdownItemsDetails,
              onChanged: (value) {
                if (value == _dropdownItemsDetails[0]) {
                  dashboardController.fetchRequestDetails(selectedDepartment!);
                } else if (value == _dropdownItemsDetails[1]) {
                  dashboardController.fetchPendingRequestDetails();
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Consumer<DashboardControllerCssdCussDeptUser>(
                  builder: (context, dashboardConsumer, child) {
                return ListView.builder(
                  itemCount: dashboardConsumer.requestDetailsList.length,
                  itemBuilder: (context, index) {
                    final acceptedTextColor =
                        hexToColorWithOpacity(hexColor: "#438369");
                    final acceptedBgColor =
                        hexToColorWithOpacity(hexColor: "5ECCA0");
                    final notAcceptedTextColor =
                        hexToColorWithOpacity(hexColor: "#7B6093");
                    final notAcceptedBgColor =
                        hexToColorWithOpacity(hexColor: "#CB9BFA");
                    final request = dashboardConsumer.requestDetailsList[index];
                    return Card(
                      color: request.isAccept == 1
                          ? acceptedBgColor
                          : notAcceptedBgColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: "${request.reqId}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            children: [
                                              TextSpan(
                                                text: ": Request Id ",
                                                style: TextStyle(
                                                    color: request.isAccept == 1
                                                        ? acceptedTextColor
                                                        : notAcceptedTextColor,
                                                    fontSize: 12),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: " Priority :",
                                      style: TextStyle(
                                          color: request.isAccept == 1
                                              ? acceptedTextColor
                                              : notAcceptedTextColor,
                                          fontSize: 12),
                                      children: [
                                        TextSpan(
                                            text: " ${request.priority}",
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Requested by : ",
                                    style: GoogleFonts.labrada(
                                        color: request.isAccept == 1
                                            ? acceptedTextColor
                                            : notAcceptedTextColor,
                                        fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: request.rUser,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Time : ",
                                    style: GoogleFonts.labrada(
                                        color: request.isAccept == 1
                                            ? acceptedTextColor
                                            : notAcceptedTextColor,
                                        fontSize: 12),
                                    children: [
                                      TextSpan(
                                        text: "${request.rTime}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Accepted : ",
                                    style: GoogleFonts.labrada(
                                        color: request.isAccept == 1
                                            ? acceptedTextColor
                                            : notAcceptedTextColor,
                                        fontSize: 12),
                                    children: [
                                      TextSpan(
                                          text: request.isAccept == 1
                                              ? "Yes"
                                              : "No",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                if (request.isAccept == 1)
                                  RichText(
                                    text: TextSpan(
                                      text: "Accepted by : ",
                                      style: GoogleFonts.labrada(
                                          color: request.isAccept == 1
                                              ? acceptedTextColor
                                              : notAcceptedTextColor,
                                          fontSize: 12),
                                      children: [
                                        TextSpan(
                                          text: "${request.acceptedUser}",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
