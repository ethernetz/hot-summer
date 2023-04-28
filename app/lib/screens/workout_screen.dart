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
          child: const Icon(
            CupertinoIcons.add,
            color: CupertinoColors.black,
            weight: 100,
          ),
          onTap: () =>
              context.read<CurrentWorkoutProvider>().addActivity(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: CustomScrollView(
          slivers: [
            CupertinoSliverNavigationBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0x01ffffff),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.back,
                  color: CupertinoColors.white,
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
                  CupertinoIcons.check_mark,
                  color: CupertinoColors.white,
                ),
                onPressed: () => completeWorkout(context),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
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
                            const Text(
                              'Use a recent workout',
                              style: TextStyle(
                                fontFamily: 'Kumbh Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            const SizedBox(height: 20),
                            for (var workout
                                in workouts.getLatestWorkoutsWithActivityLog())
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    currentWorkoutProvider.addActivities(
                                      context,
                                      workout.activities
                                          .map((activity) =>
                                              activity.activityType)
                                          .toList(),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          workout.localizedRelativeTime,
                                          style: const TextStyle(
                                            fontFamily: 'Kumbh Sans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          workout.formattedActivityNameList,
                                          style: const TextStyle(
                                            fontFamily: 'Kumbh Sans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
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
            ),
          ],
        ),
      ),
    );
  }

  void completeWorkout(BuildContext context) {
    context.read<CurrentWorkoutProvider>().endWorkout(context);
    Navigator.replaceRouteBelow(
      context,
      anchorRoute: ModalRoute.of(context)!,
      newRoute: HomeScreen.route(),
    );
    Navigator.pop(context);
  }
}
