import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';

class Workouts {
  final List<Workout> workouts;

  const Workouts({required this.workouts});

  factory Workouts.fromSnapshots(
      List<QueryDocumentSnapshot<Workout>> workoutsSnapshots) {
    return Workouts(
      workouts: workoutsSnapshots
          .map((workoutSnapshot) => workoutSnapshot.data())
          .toList(),
    );
  }

  int getNumWorkoutsSinceMonday() {
    final mostRecentMonday = _getMostRecentMonday(DateTime.now());
    return workouts.lastIndexWhere(
            (workout) => workout.timestamp.toDate().isAfter(mostRecentMonday)) +
        1;
  }

  Activity? getActivityLogFromWorkout(
    String workoutId,
    ActivityType activityType,
  ) {
    return workouts
        .firstWhere((workout) => workout.documentId == workoutId)
        .activities
        .firstWhere((activity) => activity.activityType == activityType);
  }

  List<TimestampedActivity> getAllActivityLogsWithTimestamp(
      ActivityType activityType) {
    return workouts
        .map((workout) => workout.activities
            .map((activity) => TimestampedActivity(
                timestamp: workout.timestamp.toDate(), activity: activity))
            .toList())
        .expand((timestampedActivity) => timestampedActivity)
        .where((timestampedActivity) =>
            timestampedActivity.activity.activityType == activityType)
        .toList();
  }

  List<Workout> getLatestWorkoutsWithActivityLog() {
    return workouts
        .where((workout) => workout.activities.isNotEmpty)
        .take(5)
        .toList();
  }

  DateTime _getMostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));
}
