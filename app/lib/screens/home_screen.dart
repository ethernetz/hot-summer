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
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
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
      settings: const RouteSettings(name: '/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Expanded(
          child: SingleChildScrollView(
            child: Consumer<HotUser?>(
              builder: (
                BuildContext context,
                HotUser? hotUser,
                Widget? child,
              ) {
                if (hotUser == null) {
                  return const Text('You are signed out');
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          'Home',
                          style: GoogleFonts.barlowCondensed(
                            fontWeight: FontWeight.w500,
                            fontSize: 80,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'You',
                              style: GoogleFonts.kumbhSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xff1c1c1c),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        const SizedBox(height: 10),
                        const SelfMetrics(),
                      ],
                    ),
                  ),
                );
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
