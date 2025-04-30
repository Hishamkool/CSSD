import 'package:cssd/app/modules/Department_User/view/widgets/dashboard_widgets/dahboard_buttons_widget.dart';
import 'package:flutter/material.dart';

class AnimatedDashboardButton extends StatefulWidget {
  final IconData icon;
  final String iconName;
  final VoidCallback onTap;
  final int index; // Added index for staggered effect

  const AnimatedDashboardButton({
    super.key,
    required this.icon,
    required this.iconName,
    required this.onTap,
    required this.index,
  });

  @override
  _AnimatedDashboardButtonState createState() => _AnimatedDashboardButtonState();
}

class _AnimatedDashboardButtonState extends State<AnimatedDashboardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _slideUp = Tween<Offset>(begin: const Offset(0, 1.2), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut, // Bounce effect
      ),
    );

    // Delay animation based on index
    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slideUp,
        child: DashboardButtons(
          icon: widget.icon,
          iconName: widget.iconName,
          onTap: widget.onTap,
        ),
      ),
    );
  }
}
