import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/services/current_activity_provider.dart';

class Set {
  Map<ActivityMeasurementType, num> measurements;
  Set({required this.measurements});

  String get displayMeasurements {
    if (measurements.isEmpty) {
      return '';
    }

    if (measurements.length == 1) {
      switch (measurements.keys.first) {
        case ActivityMeasurementType.reps:
          return '${measurements.values.first} reps';
        default:
          return 'implement';
      }
    }

    if (measurements.containsKey(ActivityMeasurementType.pounds) &&
        measurements.containsKey(ActivityMeasurementType.reps)) {
      return '${measurements[ActivityMeasurementType.pounds]}lbs x ${measurements[ActivityMeasurementType.reps]}';
    }

    if (measurements.containsKey(ActivityMeasurementType.additionalPounds) &&
        measurements.containsKey(ActivityMeasurementType.reps)) {
      return '+${measurements[ActivityMeasurementType.additionalPounds]}lbs x ${measurements[ActivityMeasurementType.reps]}';
    }

    if (measurements.containsKey(ActivityMeasurementType.assistedPounds) &&
        measurements.containsKey(ActivityMeasurementType.reps)) {
      return '-${measurements[ActivityMeasurementType.assistedPounds]}lbs x ${measurements[ActivityMeasurementType.reps]}';
    }

    return 'implement';
  }
}

class Activity {
  final ActivityType activityType;
  final List<Set> sets;

  Activity({required this.activityType, required this.sets});
}

class TimestampedActivity {
  final DateTime timestamp;
  final Activity activity;

  TimestampedActivity({required this.timestamp, required this.activity});
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
      return 'Today at ${DateFormat('h:mm a').format(previousTime)}';
    }
    if (difference.inDays == 1) {
      return 'Yesterday at ${DateFormat('h:mm a').format(previousTime)}';
    }
    if (difference.inDays < 7) {
      return 'Last ${DateFormat('EEEE').format(previousTime)} at ${DateFormat('h:mm a').format(previousTime)}';
    }

    return DateFormat('MMMM d').format(previousTime);
  }

  String get formattedActivityNameList {
    final activityNames = activities
        .map((activity) => activity.activityType.displayName)
        .toList();

    if (activityNames.isEmpty) {
      return '';
    }
    if (activityNames.length == 1) {
      return activityNames[0];
    }

    String formattedList =
        activityNames.sublist(0, activityNames.length - 1).join(', ');
    formattedList += ' and ${activityNames.last}';
    return formattedList;
  }

  factory Workout.fromCurrentActivities(
      List<CurrentActivityProvider> currentActivities, String documentId) {
    return Workout(
      timestamp: Timestamp.now(),
      documentId: documentId,
      activities: currentActivities.map((activity) {
        return Activity(
          activityType: activity.activityType,
          sets: activity.sets.map((set) {
            return Set(
              measurements: set.activityMeasurementTypes.asMap().map(
                    (_, measurement) => MapEntry(
                      measurement,
                      num.tryParse(
                              set.textEditingControllers[measurement]!.text) ??
                          0,
                    ),
                  ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  factory Workout.fromMap(Map<String, dynamic>? map) {
    return Workout(
      timestamp: map!['timestamp'],
      documentId: map['documentId'],
      activities: map['activities'] is Iterable
          ? List.from(map['activities'])
              .map(
                (activity) => Activity(
                  activityType: activityMap[activity['activityId']]!,
                  sets: List.from(activity['sets'])
                      .map(
                        (set) => Set(
                          measurements: activityMap[activity['activityId']]!
                              .measurementTypes
                              .asMap()
                              .map(
                                (_, measurement) => MapEntry(
                                  measurement,
                                  set[measurement.id] ?? 0,
                                ),
                              ),
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
            "activityId": activity.activityType.id,
            "sets": [
              for (var set in activity.sets)
                {
                  for (var measurement in set.measurements.entries)
                    measurement.key.id: measurement.value
                }
            ]
          }
      ]
    };
  }
}
