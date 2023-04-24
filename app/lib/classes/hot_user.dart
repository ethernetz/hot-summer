import 'package:workspaces/classes/activity_type.dart';

class HotUser {
  final String uid;
  final int streak;
  final int medals;
  final int? sessionsPerWeekGoal;
  final Map<ActivityType, List<String>> activityHistory;

  const HotUser({
    required this.uid,
    required this.streak,
    required this.medals,
    required this.sessionsPerWeekGoal,
    required this.activityHistory,
  });

  factory HotUser.fromJson(Map<String, dynamic> json) {
    return HotUser(
      uid: json['uid'],
      streak: json['streak'],
      medals: json['medals'],
      sessionsPerWeekGoal: json['sessionsPerWeekGoal'],
      activityHistory: json['activityHistory'] != null
          ? (json['activityHistory'] as Map<String, dynamic>).map(
              (activityTypeNumber, workoutIdList) => MapEntry(
                ActivityType.fromNumber(int.parse(activityTypeNumber)),
                List<String>.from(workoutIdList),
              ),
            )
          : <ActivityType, List<String>>{},
    );
  }

  Map<String, dynamic> toFirestore() {
    throw UnimplementedError(
        'Converting user to firestore user object is currently unimplemented');
  }

  isOnboarded() {
    return sessionsPerWeekGoal != null;
  }
}
