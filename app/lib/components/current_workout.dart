import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/current_activity.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/components/activity_card.dart';
import 'package:workspaces/components/select_activity.dart';
import 'package:workspaces/services/current_workout_provider.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/widgets/button.dart';

class CurrentWorkout extends StatefulWidget {
  const CurrentWorkout({super.key});

  @override
  State<CurrentWorkout> createState() => _CurrentWorkoutState();
}

class _CurrentWorkoutState extends State<CurrentWorkout> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<CurrentActivity> activities = [];
  bool addButtonExists = false;

  @override
  Widget build(BuildContext context) {
    final isWorkingOut = context.select<CurrentWorkoutProvider, bool>(
        (currentWorkoutProvider) => currentWorkoutProvider.isWorkingOut);

    if (isWorkingOut && !addButtonExists) {
      _addAddButton();
    }
    if (!isWorkingOut && addButtonExists) {
      context.read<FirestoreService>().logWorkout(context, activities);
      _removeAllActivities();
      _removeAddButton();
    }

    return AnimatedList(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      key: _listKey,
      initialItemCount: 0,
      itemBuilder: (context, index, animation) {
        if (index == activities.length) {
          return SizeTransition(
            sizeFactor: _getCurvedAnimation(animation),
            child: _buildAddActivityButton(),
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
    final activity = activities[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ChangeNotifierProvider<CurrentActivity>.value(
        value: activity,
        child: ActivityCard(
          key: activity.uniqueKey,
          onClosePressed: () => _removeActivity(index),
        ),
      ),
    );
  }

  void _addActivity() async {
    final activityType = await showCupertinoModalPopup<ActivityType>(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const CupertinoPopupSurface(
          child: SelectActivity(),
        ),
      ),
    );
    if (activityType == null) return;
    activities.add(CurrentActivity(
      uniqueKey: UniqueKey(),
      activityType: activityType,
    ));
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
      duration: const Duration(milliseconds: 100),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activities[index].dispose();
      activities.removeAt(index);
    });
  }

  void _removeAllActivities() {
    for (var i = activities.length - 1; i >= 0; i--) {
      _removeActivity(i);
    }
  }

  Button _buildAddActivityButton() {
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
          child: _buildAddActivityButton(),
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
