import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/current_activity.dart';

class Set {
  int weight;
  int reps;

  Set({required this.weight, required this.reps});
}

class Activity {
  final ActivityType activityType;
  final List<Set> sets;

  Activity({required this.activityType, required this.sets});
}

class Workout {
  final Timestamp timestamp;
  final List<Activity> activities;
  final String documentId;

  const Workout({
    required this.timestamp,
    required this.activities,
    required this.documentId,
  });

  String get localizedRelativeTime {
    final currentTime = DateTime.now();
    final previousTime = timestamp.toDate();

    final currentDate =
        DateTime(currentTime.year, currentTime.month, currentTime.day);
    final previousDate =
        DateTime(previousTime.year, previousTime.month, previousTime.day);
    final difference = currentDate.difference(previousDate);

    if (difference.inDays == 0) {
      return 'Today';
    }
    if (difference.inDays == 1) {
      return 'Yesterday';
    }
    if (difference.inDays < 7) {
      return 'Last ${DateFormat('EEEE').format(previousTime)}';
    }

    return DateFormat('MMMM d').format(previousTime);
  }

  factory Workout.fromCurrentActivities(
      List<CurrentActivity> json, String documentId) {
    return Workout(
        timestamp: Timestamp.now(),
        documentId: documentId,
        activities: json.map((activity) {
          return Activity(
              activityType: activity.activityType,
              sets: activity.sets.map((set) {
                return Set(
                    weight: int.tryParse(set.weightController.text) ?? 0,
                    reps: int.tryParse(set.repsController.text) ?? 0);
              }).toList());
        }).toList());
  }

  factory Workout.fromJson(Map<String, dynamic>? json) {
    return Workout(
      timestamp: json!['timestamp'],
      documentId: json['documentId'],
      activities: json['activities'] is Iterable
          ? List.from(json['activities'])
              .map(
                (activity) => Activity(
                  activityType:
                      ActivityType.fromNumber(activity['activityType']),
                  sets: List.from(activity['sets'])
                      .map(
                        (set) => Set(
                          weight: set['weight'],
                          reps: set['reps'],
                        ),
                      )
                      .toList(),
                ),
              )
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "timestamp": timestamp,
      "documentId": documentId,
      "activities": [
        for (var activity in activities)
          {
            "activityType": activity.activityType.number,
            "sets": [
              for (var set in activity.sets)
                {
                  "weight": set.weight,
                  "reps": set.reps,
                }
            ]
          }
      ]
    };
  }
}
