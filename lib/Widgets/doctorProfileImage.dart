import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  final String imageUrl;
  const DoctorProfile({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        width: 125.0,
        height: 160.0,
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      Positioned(
        bottom: -5.0,
        left: 0,
        right: 0,
        child: SizedBox(
          width: 125,
          height: 125,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ]);
  }
}
