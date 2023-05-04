import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/current_workout_provider.dart';

class CurrentWorkout extends StatefulWidget {
  const CurrentWorkout({super.key});

  @override
  State<CurrentWorkout> createState() => _CurrentWorkoutState();
}

class _CurrentWorkoutState extends State<CurrentWorkout> {
  GlobalKey<AnimatedListState> activitiesListKey =
      GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    context
        .read<CurrentWorkoutProvider>()
        .setActivitiesListKey(activitiesListKey);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      key: activitiesListKey,
      initialItemCount:
          context.read<CurrentWorkoutProvider>().activities.length,
      itemBuilder: (context, index, animation) {
        return context
            .read<CurrentWorkoutProvider>()
            .buildActivityCardWithAnimation(context, index, animation);
      },
    );
  }
}
