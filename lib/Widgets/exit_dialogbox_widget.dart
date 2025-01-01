
import 'package:cssd/Widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> exitDialogBox(BuildContext context) async {
  return customDialog(
    dialogContext: context,
    dialogContent: const Text("Are you sure to exit?"),
    onAcceptDefaultAction: () {
      SystemNavigator.pop();
    },
    onCancelDefaultAction: () {
      Navigator.pop(context);
    },
  );
}
