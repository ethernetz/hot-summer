import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/workouts.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class RecentWorkouts extends StatelessWidget {
  const RecentWorkouts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Workouts>(builder: (
      BuildContext context,
      Workouts workouts,
      Widget? child,
    ) {
      final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
      return ListView(
        shrinkWrap: true,
        children: [
          for (var workout in workouts.getLatestWorkoutsWithActivityLog())
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {
                  currentWorkoutProvider.addActivities(
                    context,
                    workout.activities
                        .map((activity) => activity.activityType)
                        .toList(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.localizedRelativeTime,
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        workout.formattedActivityNameList,
                        style: GoogleFonts.kumbhSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
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
}
