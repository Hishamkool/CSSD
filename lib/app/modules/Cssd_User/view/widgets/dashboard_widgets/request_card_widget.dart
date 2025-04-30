import 'package:cssd/app/modules/Cssd_User/model/dashboard_models/get_cssd_list_model.dart';
import 'package:cssd/util/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
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

    return InkWell(
      onTap: onTap,
      child: Card(
        color: StaticColors.lightBgContainer,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
                color: StaticColors.scaffoldBackgroundcolor, width: 0.01)),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: const BoxDecoration(
                      color: StaticColors.darkTextColorForBlueContainer,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      request.sid.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Department Name and Request User
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //department name
                        Row(
                          children: [
                            const Icon(
                              FluentIcons.building_16_filled,
                              color: StaticColors.darkTextColorForBlueContainer,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              request.sub,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color:
                                    StaticColors.darkTextColorForBlueContainer,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        // requested user
                        Row(
                          children: [
                            const Icon(
                              FluentIcons.person_12_filled,
                              color:
                                  StaticColors.darkTextColorForBlueContainer,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              request.ruser,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color:
                                    StaticColors.darkTextColorForBlueContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Date and Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.clock_12_filled,
                            color: StaticColors.darkTextColorForBlueContainer,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            formatedTime,
                            style: const TextStyle(
                              fontSize: 12,
                              color: StaticColors.darkTextColorForBlueContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            FluentIcons.calendar_12_filled,
                            color: StaticColors.darkTextColorForBlueContainer,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            formatedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: StaticColors.darkTextColorForBlueContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),
              // Marquee for products
              Visibility(
                visible: false,
                child: Theme(
                  data: ThemeData().copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    iconColor: StaticColors.lightTextColorForBlueContainer,
                    collapsedIconColor:
                        StaticColors.lightTextColorForBlueContainer,
                    minTileHeight: 0,
                    title: Text(
                      "Items count  (${request.productdet.length})",
                      style: const TextStyle(
                          fontSize: 14,
                          color: StaticColors.lightTextColorForBlueContainer),
                    ),
                    children: [
                      Container(
                        color: StaticColors.scaffoldBackgroundcolor,
                        height: 35,
                        child: Marquee(
                          text: allProducts,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: StaticColors.lightContainerborder,
                          ),
                          scrollAxis: Axis.horizontal,
                          blankSpace: 50.0,
                          velocity: 40.0,
                          pauseAfterRound: const Duration(seconds: 1),
                          startPadding: 10.0,
                          accelerationDuration:
                              const Duration(milliseconds: 500),
                          accelerationCurve: Curves.fastLinearToSlowEaseIn,
                          decelerationDuration:
                              const Duration(milliseconds: 200),
                          decelerationCurve: Curves.easeOut,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
