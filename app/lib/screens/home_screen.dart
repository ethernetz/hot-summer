import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/home.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/workout_screen.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return const HomeScreen();
      },
      settings: const RouteSettings(name: '/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Consumer<HotUser?>(
              builder: (
                BuildContext context,
                HotUser? hotUser,
                Widget? child,
              ) {
                if (hotUser == null) {
                  return const Text('You are signed out');
                }
                return const Home();
              },
            ),
          ),
        ),
      ),
      floatingActionButton: HeroWorkoutButton(
        child: Text(
          (currentWorkoutProvider.isWorkingOut ? 'Back to workout' : 'Workout')
              .split('')
              .join('\u200B'),
          key: ValueKey<String>(currentWorkoutProvider.isWorkingOut
              ? 'Back to workout'
              : 'Workout'),
          style: Theme.of(context).textTheme.displayMedium,
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
