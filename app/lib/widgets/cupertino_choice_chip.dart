import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoChoiceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const CupertinoChoiceChip({
    Key? key,
    required this.label,
    required this.onSelected,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      borderRadius: BorderRadius.circular(16),
      color: isSelected
          ? Theme.of(context).colorScheme.primary
          : CupertinoColors.white.withOpacity(0.9),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? CupertinoColors.black
              : CupertinoColors.black.withOpacity(0.9),
          fontSize: 16.0,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () => onSelected(!isSelected),
    );
  }
}
