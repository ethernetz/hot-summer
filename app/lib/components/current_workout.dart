import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/activity_card.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:workspaces/widgets/button.dart';
import 'dart:math';

class CurrentWorkout extends StatefulWidget {
  const CurrentWorkout({super.key});

  @override
  State<CurrentWorkout> createState() => _CurrentWorkoutState();
}

class _CurrentWorkoutState extends State<CurrentWorkout> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> activities = [];
  bool addButtonExists = false;

  @override
  Widget build(BuildContext context) {
    final isWorkingOut = context.select<CurrentWorkoutProvider, bool>(
        (currentWorkoutProvider) => currentWorkoutProvider.isWorkingOut);

    if (isWorkingOut && !addButtonExists) {
      addAddButton();
    }
    if (!isWorkingOut) {
      if (activities.isNotEmpty) {
        removeAllActivities();
      }
      if (addButtonExists) {
        removeAddButton();
      }
    }

    return AnimatedList(
      shrinkWrap: true,
      key: _listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        if (index == activities.length) {
          return SizeTransition(
            sizeFactor: curvedAnimation,
            child: Button(
              child: const Text('Add activity'),
              onPressed: () => addActivity(),
            ),
          );
        }

        return SizeTransition(
          sizeFactor: curvedAnimation,
          child: Dismissible(
            key: Key('${activities[index].hashCode}'),
            onDismissed: (direction) => removeActivity(index),
            background: Container(color: Colors.red[700]),
            direction: DismissDirection.startToEnd,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ActivityCard(
                activity: activities[index],
                onClosePressed: () => removeActivity(index),
              ),
            ),
          ),
        );
      },
    );
  }

  void addActivity() {
    activities.add('item ${Random().nextInt(100)}');
    _listKey.currentState?.insertItem(
      activities.length - 1,
      duration: const Duration(milliseconds: 250),
    );
  }

  void removeActivity(int index) {
    final activity = activities[index];
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: ActivityCard(
            activity: activity,
            onClosePressed: () => {},
          ),
        );
      },
      duration: const Duration(milliseconds: 100),
    );
    activities.removeAt(index);
  }

  void removeAllActivities() {
    for (var i = activities.length - 1; i >= 0; i--) {
      removeActivity(i);
    }
  }

  void addAddButton() {
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 100),
    );
    addButtonExists = true;
  }

  void removeAddButton() {
    _listKey.currentState?.removeItem(
      0,
      (
        BuildContext context,
        Animation<double> animation,
      ) {
        return SizeTransition(
          sizeFactor: animation,
          child: Button(
            child: const Text('Add activity'),
            onPressed: () => addActivity(),
          ),
        );
      },
      duration: const Duration(milliseconds: 100),
    );
    addButtonExists = false;
  }
}
