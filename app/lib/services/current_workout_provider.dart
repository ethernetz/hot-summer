import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/services/current_activity_provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/workout.dart';
import 'package:workspaces/classes/workouts.dart';
import 'package:workspaces/components/current_activity.dart';
import 'package:workspaces/components/select_activity.dart';
import 'package:workspaces/services/firestore_service.dart';

class CurrentWorkoutProvider extends ChangeNotifier {
  bool _isWorkingOut = false;
  bool get isWorkingOut => _isWorkingOut;
  GlobalKey<AnimatedListState>? _activitiesListKey;
  final List<CurrentActivityProvider> activities = [];

  void startWorkout() {
    _isWorkingOut = true;

    notifyListeners();
  }

  void endWorkout(BuildContext context) {
    _isWorkingOut = false;
    context.read<FirestoreService>().logWorkout(context, activities);
    _removeAllActivities();
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
      activities.add(CurrentActivityProvider(
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

  void addActivities(
      BuildContext context, List<ActivityType> activityTypes) async {
    for (var activityType in activityTypes) {
      activities.add(CurrentActivityProvider(
        uniqueKey: UniqueKey(),
        activityType: activityType,
        previousActivity: _getPreviousActivity(context, activityType),
      ));
      _activitiesListKey?.currentState?.insertItem(
        activities.length - 1,
        duration: const Duration(milliseconds: 100),
      );
    }

    notifyListeners();
  }

  void _removeActivity(int index) {
    final activityCard = _buildCurrentActivity(index);
    _activitiesListKey?.currentState?.removeItem(
      index,
      (context, animation) {
        return FadeTransition(
          opacity: _getCurvedAnimation(animation),
          child: SizeTransition(
            sizeFactor: _getCurvedAnimation(animation),
            child: activityCard,
          ),
        );
      },
      duration: const Duration(milliseconds: 100),
    );
    final activity = activities[index];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activity.dispose();
    });
    activities.removeAt(index);
    notifyListeners();
  }

  void _removeAllActivities() {
    for (var i = activities.length - 1; i >= 0; i--) {
      _removeActivity(i);
    }
  }

  Widget buildCurrentActivityWithAnimation(
      BuildContext context, int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: _getCurvedAnimation(animation),
      child: _buildCurrentActivity(index),
    );
  }

  Widget _buildCurrentActivity(int index) {
    final activity = activities[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ChangeNotifierProvider<CurrentActivityProvider>.value(
        value: activity,
        child: CurrentActivity(
          key: activity.uniqueKey,
          onClosePressed: () => _removeActivity(index),
        ),
      ),
    );
  }

  Activity? _getPreviousActivity(
      BuildContext context, ActivityType activityType) {
    final latestWorkoutIdWithActivityLogged = context
        .read<HotUser>()
        .getLatestWorkoutIdWithActivityLogged(activityType);
    if (latestWorkoutIdWithActivityLogged == null) return null;
    return context.read<Workouts>().getActivityLogFromWorkout(
          latestWorkoutIdWithActivityLogged,
          activityType,
        );
  }

  CurvedAnimation _getCurvedAnimation(Animation<double> animation) {
    return CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );
  }
}
