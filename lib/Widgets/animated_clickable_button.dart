import 'package:cssd/util/colors.dart';
import 'package:flutter/material.dart';

class AnimatedHoverButton extends StatefulWidget {
  const AnimatedHoverButton(
      {super.key, required this.buttonChild, required this.onClickFunction});
  final Widget buttonChild;
  final void Function() onClickFunction;
  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  double _padding = 6;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _padding = 0;
        });
      },
      onTapUp: (details) {
        setState(() {
          _padding = 6;
        });
      },
      onTap: widget.onClickFunction,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(bottom: _padding),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xff091e3a),
                  Color(0xff2f80ed),
                  Color(0xff2d9ee0)
                ],
                stops: [0, 0.5, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: widget.buttonChild,
        ),
      ),
    );
  }
}
