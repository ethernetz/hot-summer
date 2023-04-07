import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:workspaces/widgets/hot_button.dart';

class WorkoutButton extends StatelessWidget {
  const WorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HotButton(
        onPressed: () {
          final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
          currentWorkoutProvider.isWorkingOut
              ? currentWorkoutProvider.endWorkout()
              : currentWorkoutProvider.startWorkout();
        },
        child: Selector<CurrentWorkoutProvider, bool>(
          selector: (_, provider) => provider.isWorkingOut,
          builder: (_, isWorkingOut, __) {
            return isWorkingOut
                ? Text(
                    "COMPLETE WORKOUT",
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  )
                : Text(
                    "START WORKOUT",
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  );
          },
        ));
  }
}
