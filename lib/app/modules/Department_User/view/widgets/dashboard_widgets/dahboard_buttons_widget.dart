import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

// used items , send to cssd ..... other buttons
class DashboardButtons extends StatelessWidget {
  const DashboardButtons({
    super.key,
    required this.icon,
    required this.iconName,
    this.onTap,
  });

  final IconData icon;
  final String iconName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          //single item
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                
                  borderRadius: BorderRadius.circular(10),
                  color: StaticColors.scaffoldBackgroundcolor),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            SizedBox(
                width: 50,
                child: Text(
                  iconName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
