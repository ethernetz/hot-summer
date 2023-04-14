import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/home.dart';
import 'package:workspaces/components/workout_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: CustomPaint(
                size: const Size(200, 200),
                painter: OrbPainter(),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                child: Consumer<HotUser?>(
                  builder: (BuildContext context, hotUser, Widget? child) {
                    if (hotUser?.sessionsPerWeekGoal == null) {
                      return const Text('You are signed out');
                    }
                    return const Home();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: WorkoutButton(
        text: 'Workout',
        onTap: () => Navigator.pushNamed(context, '/workout'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class OrbPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const gradient = LinearGradient(
      colors: [
        Color(0xffED6F00),
        Color(0xffAF0BE6),
      ],
      stops: [0.0, 1.0],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    final paint = Paint()
      ..shader =
          gradient.createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    final rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height * 0.6,
    );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-45 * (3.14159265359 / 180)); // Rotate 45 degrees
    canvas.translate(-center.dx, -center.dy);

    canvas.drawOval(rect, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
