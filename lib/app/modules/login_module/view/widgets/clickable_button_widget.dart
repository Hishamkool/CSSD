import 'package:flutter/material.dart';

class AnimatedHoverButton extends StatefulWidget {
  const AnimatedHoverButton(
      {super.key,
      required this.borderRadius,
      required this.backgroundColor,
      required this.hoverColor,
      required this.buttonContent,
      required this.containerHeight,
      required this.containerWidth,
      required this.ontap});

  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color hoverColor;
  final Widget buttonContent;
  final double containerHeight;
  final double containerWidth;
  final void Function() ontap;

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
      child: AnimatedContainer(
        
        onEnd: widget.ontap ,
        duration: const Duration(milliseconds: 100),
        padding: EdgeInsets.only(bottom: _padding),
        decoration: BoxDecoration(
            color: widget.hoverColor, borderRadius: widget.borderRadius),
        child: Container(
          height: widget.containerHeight,
          width: widget.containerWidth,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: widget.backgroundColor, borderRadius: widget.borderRadius),
          child: widget.buttonContent,
        ),
      ),
    );
  }
}
