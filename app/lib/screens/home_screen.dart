import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/home.dart';

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
      floatingActionButton: const WorkoutButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class WorkoutButton extends StatelessWidget {
  const WorkoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/workout');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade800.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/flexed_biceps_3d_default.png"),
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    'Workout',
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
