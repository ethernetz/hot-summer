import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/workouts.dart';
import 'package:workspaces/widgets/frosted.dart';
import 'package:workspaces/widgets/progress_bar.dart';

class SelfMetrics extends StatelessWidget {
  const SelfMetrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var hotuser = context.watch<HotUser?>();
    var workouts = context.watch<Workouts>();
    if (hotuser == null) {
      return const SizedBox();
    }
    final numWorkoutsSinceMonday = workouts.getNumWorkoutsSinceMonday();
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Frosted(
                child: Container(
                  height: 125,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hotuser.streak.toString(),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const Image(
                            image: AssetImage("assets/fire_3d.png"),
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                      Text(
                        'Streak',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: Frosted(
                child: Container(
                  height: 125,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hotuser.medals.toString(),
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const Image(
                            image: AssetImage("assets/1st_place_medal_3d.png"),
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                      Text(
                        'Medals',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Frosted(
          child: Container(
            height: 125,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 275,
                  child: ProgressBar(
                    currentValue: numWorkoutsSinceMonday,
                    maxValue: hotuser.sessionsPerWeekGoal!,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  numWorkoutsSinceMonday >= hotuser.sessionsPerWeekGoal!
                      ? 'Hell yeah! $numWorkoutsSinceMonday workouts this week'
                      : '${hotuser.sessionsPerWeekGoal! - numWorkoutsSinceMonday} sessions left this week',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
