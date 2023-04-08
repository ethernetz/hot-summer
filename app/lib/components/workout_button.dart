import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/widgets/hot_button.dart';

class WorkoutButton extends StatelessWidget {
  const WorkoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return HotButton(
      onPressed: () {
        final currentWorkoutProvider = context.read<CurrentWorkoutProvider>();
        if (currentWorkoutProvider.isWorkingOut) {
          context.read<FirestoreService>().logWorkout(context);
          currentWorkoutProvider.endWorkout();
        } else {
          currentWorkoutProvider.startWorkout();
        }
      },
      child: Selector<CurrentWorkoutProvider, bool>(
        selector: (_, provider) => provider.isWorkingOut,
        builder: (_, isWorkingOut, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 25),
            child: Builder(
              key: ValueKey(isWorkingOut),
              builder: (BuildContext context) {
                if (isWorkingOut) {
                  return Container(
                    height: 37,
                    alignment: Alignment.center,
                    child: Text(
                      "COMPLETE WORKOUT",
                      style: GoogleFonts.kumbhSans(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  );
                } else {
                  return Text(
                    "START WORKOUT",
                    style: GoogleFonts.kumbhSans(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}