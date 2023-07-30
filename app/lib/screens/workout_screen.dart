import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/current_workout.dart';
import 'package:workspaces/components/recent_workouts.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/screens/home_screen.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:animations/animations.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (context) => const WorkoutScreen(),
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
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () => completeWorkout(context),
                      icon: const Icon(
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Workout',
                          style: GoogleFonts.kumbhSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Consumer<CurrentWorkoutProvider>(builder: (
                          BuildContext context,
                          CurrentWorkoutProvider currentWorkout,
                          Widget? child,
                        ) {
                          return PageTransitionSwitcher(
                            duration: const Duration(milliseconds: 300),
                            reverse: currentWorkout.activities.isEmpty,
                            layoutBuilder: (List<Widget> entries) => Stack(
                              children: entries,
                            ),
                            transitionBuilder: (
                              Widget child,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                            ) {
                              return SharedAxisTransition(
                                animation: animation,
                                secondaryAnimation: secondaryAnimation,
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                fillColor: Colors.transparent,
                                child: child,
                              );
                            },
                            child: currentWorkout.activities.isNotEmpty
                                ? const CurrentWorkout()
                                : const RecentWorkouts(),
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
      ),
      floatingActionButton: HeroWorkoutButton(
        onTap: () =>
            context.read<CurrentWorkoutProvider>().addActivity(context),
        child: const Icon(
          CupertinoIcons.plus,
          color: Colors.black,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
