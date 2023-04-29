import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/current_workout.dart';
import 'package:workspaces/components/recent_workouts.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  static Route<dynamic> route() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const WorkoutScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1, 0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
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
    return Scaffold(
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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => completeWorkout(context),
                    child: const Icon(
                      CupertinoIcons.checkmark_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Workout',
                        style: GoogleFonts.barlowCondensed(
                          fontWeight: FontWeight.w500,
                          fontSize: 80,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Consumer<CurrentWorkoutProvider>(builder: (
                        BuildContext context,
                        CurrentWorkoutProvider currentWorkout,
                        Widget? child,
                      ) {
                        if (currentWorkout.activities.isNotEmpty) {
                          return const CurrentWorkout();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Use a recent workout',
                              style: GoogleFonts.kumbhSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              thickness: 1,
                            ),
                            const SizedBox(height: 10),
                            const RecentWorkouts(),
                          ],
                        );
                      }),
                    ],
                  ),
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
