import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final Color color;
  final Gradient? gradient;
  final void Function()? onPressed;

  const Button({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.purple,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color,
          gradient: gradient,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
