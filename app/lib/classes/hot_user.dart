import 'package:workspaces/classes/activity_type.dart';

class HotUser {
  final String uid;
  final int streak;
  final int stars;
  final int medals;
  final int? sessionsPerWeekGoal;
  final Map<ActivityType, List<String>> activityHistory;
  final List<ActivityType> customActivities;

  const HotUser({
    required this.uid,
    required this.streak,
    required this.stars,
    required this.medals,
    required this.sessionsPerWeekGoal,
    required this.activityHistory,
    required this.customActivities,
  });

  factory HotUser.fromMap(Map<String, dynamic> map) {
    final customActivities = map['customActivities'] != null
        ? (map['customActivities'] as Map<String, dynamic>)
            .entries
            .map((entry) =>
                ActivityType.fromMap(entry.value as Map<String, dynamic>))
            .toList()
        : <ActivityType>[];

    final customActivitiesMap = {
      for (var activity in customActivities) activity.id: activity
    };

    return HotUser(
      uid: map['uid'],
      streak: map['streak'],
      stars: map['stars'] ?? 0,
      medals: map['medals'],
      sessionsPerWeekGoal: map['sessionsPerWeekGoal'],
      activityHistory: map['activityHistory'] != null
          ? (map['activityHistory'] as Map<String, dynamic>).map(
              (activityId, workoutIdList) => MapEntry(
                (activityMap[activityId] ?? customActivitiesMap[activityId])!,
                List<String>.from(workoutIdList),
              ),
            )
          : <ActivityType, List<String>>{},
      customActivities: customActivities,
    );
  }

  Map<String, dynamic> toFirestore() {
    throw UnimplementedError(
        'Converting user to firestore user object is currently unimplemented');
  }

  bool isOnboarded() {
    return sessionsPerWeekGoal != null;
  }

  String? getLatestWorkoutIdWithActivityLogged(ActivityType activityType) {
    return activityHistory[activityType]?.last;
  }
}
