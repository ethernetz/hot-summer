import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/current_activity.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/workout.dart';
import 'package:workspaces/classes/workouts.dart';
import 'package:workspaces/components/activity_card.dart';
import 'package:workspaces/components/select_activity.dart';

class CurrentWorkoutProvider extends ChangeNotifier {
  bool _isWorkingOut = false;
  bool get isWorkingOut => _isWorkingOut;
  GlobalKey<AnimatedListState>? _activitiesListKey;
  final List<CurrentActivity> activities = [];

  void startWorkout() {
    _isWorkingOut = true;

    notifyListeners();
  }

  void endWorkout() {
    _isWorkingOut = false;
    notifyListeners();
  }

  void setActivitiesListKey(GlobalKey<AnimatedListState> activitiesListKey) {
    _activitiesListKey = activitiesListKey;
  }

  void addActivity(BuildContext context) async {
    await showCupertinoModalPopup<ActivityType>(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: const CupertinoPopupSurface(
          child: SelectActivity(),
        ),
      ),
    ).then((activityType) {
      if (activityType == null) return;
      activities.add(CurrentActivity(
        uniqueKey: UniqueKey(),
        activityType: activityType,
        previousActivity: _getPreviousActivity(context, activityType),
      ));
      _activitiesListKey?.currentState?.insertItem(
        activities.length - 1,
        duration: const Duration(milliseconds: 100),
      );
      notifyListeners();
    });
  }

  void removeActivity(BuildContext context, int index) {
    final activityCard = _buildActivityCard(context, index);
    _activitiesListKey?.currentState?.removeItem(
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
    notifyListeners();
  }

  Widget buildActivityCardWithAnimation(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: _getCurvedAnimation(animation),
      child: _buildActivityCard(context, index),
    );
  }

  Widget _buildActivityCard(BuildContext context, int index) {
    final activities = context.watch<CurrentWorkoutProvider>().activities;
    final activity = activities[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ChangeNotifierProvider<CurrentActivity>.value(
        value: activity,
        child: ActivityCard(
          key: activity.uniqueKey,
          onClosePressed: () => removeActivity(context, index),
        ),
      ),
    );
  }

  Activity? _getPreviousActivity(
      BuildContext context, ActivityType activityType) {
    final workoutIdOfPreviousActivity =
        context.read<HotUser>().activityHistory[activityType]?.last;
    if (workoutIdOfPreviousActivity == null) return null;
    return context
        .read<Workouts>()
        .workouts
        .firstWhere(
            (workout) => workout.documentId == workoutIdOfPreviousActivity)
        .activities
        .firstWhere((activity) => activity.activityType == activityType);
  }

  CurvedAnimation _getCurvedAnimation(Animation<double> animation) {
    return CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );
  }
}
