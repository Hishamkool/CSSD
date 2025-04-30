import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Badge(
      label: Text("0"),
      child: Icon(
        Icons.notifications,
        size: 23,
        color: Colors.white,
      ),
    );
  }
}
