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
      _addAddButton();
    }
    if (!isWorkingOut) {
      if (activities.isNotEmpty) {
        _removeAllActivities();
      }
      if (addButtonExists) {
        _removeAddButton();
      }
    }

    return AnimatedList(
      shrinkWrap: true,
      key: _listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        if (index == activities.length) {
          return SizeTransition(
            sizeFactor: _getCurvedAnimation(animation),
            child: _buildAddButton(),
          );
        }

        return SizeTransition(
          sizeFactor: _getCurvedAnimation(animation),
          child: _buildActivityCard(index),
        );
      },
    );
  }

  Widget _buildActivityCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ActivityCard(
        activity: activities[index],
        onClosePressed: () => _removeActivity(index),
      ),
    );
  }

  void _addActivity() {
    activities.add('item ${Random().nextInt(100)}');
    _listKey.currentState?.insertItem(
      activities.length - 1,
      duration: const Duration(milliseconds: 100),
    );
  }

  void _removeActivity(int index) {
    final activityCard = _buildActivityCard(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: _getCurvedAnimation(animation),
          child: activityCard,
        );
      },
      duration: const Duration(milliseconds: 1000),
    );
    activities.removeAt(index);
  }

  void _removeAllActivities() {
    for (var i = activities.length - 1; i >= 0; i--) {
      _removeActivity(i);
    }
  }

  Button _buildAddButton() {
    return Button(
      onPressed: () => _addActivity(),
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

  void _addAddButton() {
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 100),
    );
    addButtonExists = true;
  }

  void _removeAddButton() {
    _listKey.currentState?.removeItem(
      0,
      (
        BuildContext context,
        Animation<double> animation,
      ) {
        return SizeTransition(
          sizeFactor: _getCurvedAnimation(animation),
          child: _buildAddButton(),
        );
      },
      duration: const Duration(milliseconds: 100),
    );
    addButtonExists = false;
  }

  CurvedAnimation _getCurvedAnimation(Animation<double> animation) {
    return CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );
  }
}
