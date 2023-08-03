import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/self_metrics.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/settings_screen.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.push(context, SettingsScreen.route()),
            child: const Icon(
              Icons.settings,
              color: CupertinoColors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: const SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hey hey',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  SelfMetrics(),
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
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 30,
            color: CupertinoColors.black,
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
