import 'package:cssd/app/modules/Cssd_User/controller/dashboard_controller.dart';
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
                ),
                Visibility(
                  /*  visible: int.parse(countText) == 0 ? false : true, */
                  visible: dashboardConsumer.isLoadingRequestsApi == false,
                  child: Text(
                    "( $countText )",
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
