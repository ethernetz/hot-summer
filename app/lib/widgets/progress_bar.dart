import 'dart:math';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final int currentValue;
  final int maxValue;
  const ProgressBar(
      {Key? key, required this.currentValue, required this.maxValue})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double _widthFactor = 0.0;

  @override
  void initState() {
    super.initState();
    _widthFactor = min(widget.currentValue, widget.maxValue) / widget.maxValue;
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue ||
        oldWidget.maxValue != widget.maxValue) {
      setState(() {
        _widthFactor =
            min(widget.currentValue, widget.maxValue) / widget.maxValue;
      });
    }
  }

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
      child: AnimatedFractionallySizedBox(
        widthFactor: _widthFactor,
        heightFactor: 1,
        curve: Curves.easeOutCubic,
        duration: const Duration(seconds: 1),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color(0xff8D0BB4),
          ),
        ),
      ),
    );
  }
}
