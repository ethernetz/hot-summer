import 'package:cloud_firestore/cloud_firestore.dart';
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
    final mostRecentMonday = getMostRecentMonday(DateTime.now());
    return workouts.lastIndexWhere(
            (workout) => workout.timestamp.toDate().isAfter(mostRecentMonday)) +
        1;
  }

  DateTime getMostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));
}
