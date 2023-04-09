import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            child: buildAddButton(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: ActivityCard(
            activity: activities[index],
            onClosePressed: () => removeActivity(index),
          ),
        );
      },
    );
  }

  void addActivity() {
    activities.add('item ${Random().nextInt(100)}');
    _listKey.currentState?.insertItem(
      activities.length - 1,
      duration: const Duration(milliseconds: 100),
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

  Button buildAddButton() {
    return Button(
      onPressed: () => addActivity(),
      // gradient: const LinearGradient(
      //   begin: Alignment.centerLeft,
      //   end: Alignment.centerRight,
      //   colors: [
      //     Color(0xff668ae7),
      //     Color(0xff668ffa),
      //   ],
      // ),
      color: const Color(0xFFC32B9C),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            "Add activity",
            style: GoogleFonts.kumbhSans(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
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
          child: buildAddButton(),
        );
      },
      duration: const Duration(milliseconds: 100),
    );
    addButtonExists = false;
  }
}
