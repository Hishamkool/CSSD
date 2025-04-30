import 'package:flutter/material.dart';
// the top bar that is present at the top of a bottom model sheet 
class BottomSheetDivider extends StatelessWidget {
  const BottomSheetDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
