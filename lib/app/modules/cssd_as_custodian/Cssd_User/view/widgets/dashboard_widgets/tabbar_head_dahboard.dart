import 'package:cssd/app/modules/cssd_as_custodian/Cssd_User/controller/dashboard_controller.dart';
import 'package:cssd/util/hex_to_color_with_opacity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DashboardTabBarHead extends StatelessWidget {
  final String titleText;
  final String countText;
  final int tabIndex;

  const DashboardTabBarHead({
    super.key,
    required this.titleText,
    required this.countText,
    required this.tabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardController>(
        builder: (context, dashboardConsumer, child) {
      bool isSelected =
          dashboardConsumer.selectedTabbarIndex == tabIndex ? true : false;
      // log("is selected value: $isSelected  , controller value: ${dashboardController.selectedIndex}, tabindex $tabIndex");
      return Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleText,
                  style: isSelected
                      ? GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)
                      : GoogleFonts.plusJakartaSans(
                          color: const Color(0xff307AB0)),
                ),
                Visibility(
                  visible: isSelected,
                  child: Center(
                    child: Text(
                      "( $countText )",
                      style: GoogleFonts.plusJakartaSans(color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
