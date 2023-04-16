import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/current_workout.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: HeroWorkoutButton(
          text: 'Complete workout',
          onTap: () {
            // context.read<CurrentWorkoutProvider>().endWorkout(context);
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.systemGrey2,
                ),
                onPressed: () => Navigator.pop(context, null),
              ),
              largeTitle: const Text(
                'Thursday, April 14',
                style: TextStyle(color: Colors.white),
              ),
              trailing: CupertinoButton(
                child: const Icon(
                  CupertinoIcons.plus,
                  color: CupertinoColors.systemGrey2,
                ),
                onPressed: () =>
                    context.read<CurrentWorkoutProvider>().addActivity(context),
              ),
            ),
            const SliverFillRemaining(
              // child: CurrentWorkout(),
              child: CurrentWorkout(),
            ),
          ],
        ),
      ),
    );
  }
}
