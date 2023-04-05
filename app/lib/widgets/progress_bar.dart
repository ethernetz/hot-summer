import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int currentValue;
  final int maxValue;
  const ProgressBar(
      {super.key, required this.currentValue, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[900]!,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: FractionallySizedBox(
        widthFactor: currentValue / maxValue,
        heightFactor: 1,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0xff8a12f7),
          ),
        ),
      ),
    );
  }
}
