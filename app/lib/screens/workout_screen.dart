import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/workouts.dart';
import 'package:workspaces/components/current_workout.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return const WorkoutScreen();
      },
      settings: const RouteSettings(name: '/workout'),
    );
  }

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);

    void animationStatusListener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.replaceRouteBelow(
            context,
            anchorRoute: ModalRoute.of(context)!,
            newRoute: HomeScreen.route(),
          );
        });
        route!.animation?.removeStatusListener(animationStatusListener);
      }
    }

    route!.animation!.addStatusListener(animationStatusListener);
    return DefaultTextStyle(
      style: const TextStyle(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: HeroWorkoutButton(
          text: 'Complete workout',
          onTap: () {
            context.read<CurrentWorkoutProvider>().endWorkout(context);
            Navigator.replaceRouteBelow(
              context,
              anchorRoute: ModalRoute.of(context)!,
              newRoute: HomeScreen.route(),
            );
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.systemGrey2,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              largeTitle: const Text(
                'Thursday, April 14',
                style: TextStyle(color: Colors.white),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.plus,
                  color: CupertinoColors.systemGrey2,
                ),
                onPressed: () =>
                    context.read<CurrentWorkoutProvider>().addActivity(context),
              ),
            ),
            SliverFillRemaining(
              child: Consumer<CurrentWorkoutProvider>(
                builder: (
                  BuildContext context,
                  CurrentWorkoutProvider currentWorkoutProvider,
                  Widget? child,
                ) {
                  if (currentWorkoutProvider.activities.isEmpty) {
                    return Consumer<Workouts>(builder: (
                      BuildContext context,
                      Workouts workouts,
                      Widget? child,
                    ) {
                      return ListView(
                        children: [
                          for (var workout
                              in workouts.getLatestWorkoutsWithActivityLog())
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Text(workout.localizedRelativeTime)
                                  ],
                                ),
                              ),
                            )
                        ],
                      );
                    });
                  }
                  return const CurrentWorkout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
