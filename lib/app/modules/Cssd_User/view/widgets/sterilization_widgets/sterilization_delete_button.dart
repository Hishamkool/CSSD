import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(6.0), // Adjust padding here
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Adjust border radius here
        ),
        backgroundColor: Colors.white, // Adjust background color if needed
        elevation: 2, // Add elevation if needed
      ),
      onPressed: () {
        // Define action on button press
      },
      child: Icon(
        Icons.delete,
        color: Colors.red.shade800,
      ),
    );
  }
}