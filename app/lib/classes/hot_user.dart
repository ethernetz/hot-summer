class HotUser {
  final String uid;
  final String? displayName;
  final String? email;
  final int streak;
  final int medals;
  final int? sessionsPerWeekGoal;

  const HotUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.streak,
    required this.medals,
    required this.sessionsPerWeekGoal,
  });

  factory HotUser.fromJson(Map<String, dynamic> json) {
    return HotUser(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
      streak: json['streak'],
      medals: json['medals'],
      sessionsPerWeekGoal: json['sessionsPerWeekGoal'],
    );
  }
}
