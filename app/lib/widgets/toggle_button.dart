// create a button that accepts a child and an isSelected boolean value. when the value is true, the button should be green. when the value is false, the button should be red
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final void Function()? onPressed;

  const ToggleButton({
    super.key,
    required this.child,
    this.isSelected = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
