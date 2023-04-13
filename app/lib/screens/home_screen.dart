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
      body: SafeArea(
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/workout');
          },
          child: Container(
            width: 220,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.shade800.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/fire_3d.png"),
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 5,
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
    );
  }
}
