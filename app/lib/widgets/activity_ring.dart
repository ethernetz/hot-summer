import 'dart:math';
import 'package:flutter/material.dart';

class ActivityRing extends StatefulWidget {
  final int currentValue;
  final int maxValue;
  const ActivityRing(
      {Key? key, required this.currentValue, required this.maxValue})
      : super(key: key);

  @override
  State<ActivityRing> createState() => _ActivityRingState();
}

class _ActivityRingState extends State<ActivityRing>
    with SingleTickerProviderStateMixin {
  double _progressFactor = 0.0;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration:
        const Duration(milliseconds: 1000), // Change the duration as needed
  );
  late Animation<double> _animation =
      Tween<double>(begin: 0, end: _progressFactor)
          .animate(_animationController)
        ..addListener(
          () {
            setState(() {});
          },
        );

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void didUpdateWidget(ActivityRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentValue != widget.currentValue ||
        oldWidget.maxValue != widget.maxValue) {
      setState(() {
        _progressFactor = min(widget.currentValue / widget.maxValue, 1);
      });
      _animation = Tween<double>(begin: _animation.value, end: _progressFactor)
          .animate(_animationController);
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: ActivityRingPainter(_animation.value),
    );
  }
}

class ActivityRingPainter extends CustomPainter {
  final double progressFactor;
  final double strokeWidth = 8.0;

  ActivityRingPainter(this.progressFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    final Paint backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint foregroundPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final double sweepAngle = 2 * pi * progressFactor;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
