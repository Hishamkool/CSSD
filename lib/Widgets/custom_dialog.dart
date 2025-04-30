import 'package:flutter/material.dart';

/*usage 
 customDialog(
   dialogContext: context,
    dialogShowDefaultActions: false,
     dialogTitle: const Text("data"),
     dialogActions: [
     ButtonWidget(
        borderRadius: 10,
        buttonLabel: "hai",
        onPressed: () {},
      )
    ], dialogContent: null);

*/

@override
Future<void> customDialog({
  required BuildContext dialogContext,
  Widget? dialogTitle,
  required Widget dialogContent,
  List<Widget>? dialogActions,
  bool dialogShowDefaultActions = true,
  String defaultAcceptText = "Ok",
  String defaultCancelText = "Cancel",
  void Function()? onCancelDefaultAction,
  void Function()? onAcceptDefaultAction,
}) async {
  return showDialog(

      // useSafeArea: true,
      context: dialogContext,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: dialogTitle,
          content: dialogContent,
          actions: dialogShowDefaultActions
              ? _defaultActions(context,
                  onCancelDefaultAction: onCancelDefaultAction,
                  onAcceptDefaultAction: onAcceptDefaultAction,
                  defaultAcceptText: defaultAcceptText,
                  defaultCancelText: defaultCancelText)
              : dialogActions,
        );
      });
}

List<Widget> _defaultActions(BuildContext context,
    {void Function()? onCancelDefaultAction,
    void Function()? onAcceptDefaultAction,
    required String defaultAcceptText,
    required String defaultCancelText}) {
  return [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        // Navigator.of(context).pop(false);
        onCancelDefaultAction!();
      },
      child: Text(
        defaultCancelText,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(defaultAcceptText,
            style: const TextStyle(color: Colors.white)),
        onPressed: () {
          onAcceptDefaultAction!();
        }),
  ];
}
