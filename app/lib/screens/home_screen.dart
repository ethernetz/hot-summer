import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/self_metrics.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/workout_screen.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (context) => const HomeScreen(),
      settings: const RouteSettings(name: '/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
    final hotUser = context.read<HotUser?>();
    if (hotUser == null) {
      return const Text('You are signed out');
    }
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white60,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Hey hey',
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const SelfMetrics(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: HeroWorkoutButton(
        child: Text(
          (currentWorkoutProvider.isWorkingOut ? 'Back to workout' : 'Workout')
              .split('')
              .join('\u200B'),
          key: ValueKey<String>(
            currentWorkoutProvider.isWorkingOut ? 'Back to workout' : 'Workout',
          ),
          style: GoogleFonts.kumbhSans(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: Colors.black,
          ),
          maxLines: 1,
        ),
        onTap: () {
          if (!currentWorkoutProvider.isWorkingOut) {
            context.read<CurrentWorkoutProvider>().startWorkout();
          }

          Navigator.of(context).push(WorkoutScreen.route());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
