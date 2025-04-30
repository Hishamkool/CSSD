import 'package:flutter/material.dart';

class DottedDividerWithText extends StatelessWidget {
  final String text;

  const DottedDividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade200,
            thickness: 1,
            endIndent: 5,
          ),
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade200,
            thickness: 1,
            indent: 5,
          ),
        ),
      ],
    );
  }
}
