import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/model/dashboard_models/get_cssd_list_model.dart';
import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class RequestCard extends StatelessWidget {
  final HighMedLowReqModel request;
  final void Function() onTap;

  const RequestCard({super.key, required this.request, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // to get products in each map
    final allProducts =
        request.productdet.map((pdt) => pdt.productName).join(' , ');
    final requestedTime = request.rTime;
    String formatedTime = DateFormat('hh:mm a').format(requestedTime);
    String formatedDate = DateFormat('dd/MMM/yyy').format(requestedTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: StaticColors.scaffoldBackgroundcolor,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Request ID
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: const BoxDecoration(
                        color:  Color(0xffF0F5FA),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(12)),
                      ),
                      child: Text(
                        request.sid.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Department Name and Request User
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request.sub, //department name
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // requested user
                          Text(
                            request.ruser,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Date and Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatedTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatedDate,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                const SizedBox(height: 8),
                // Marquee for products
                SizedBox(
                  height: 20,
                  child: Marquee(
                    text: allProducts,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 50.0,
                    velocity: 40.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(milliseconds: 500),
                    accelerationCurve: Curves.fastLinearToSlowEaseIn,
                    decelerationDuration: const Duration(milliseconds: 200),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
