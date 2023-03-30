class HotUser {
  final String uid;
  final String displayName;
  final String email;

  const HotUser({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  factory HotUser.fromJson(Map<String, dynamic> json) {
    return HotUser(
      uid: json['uid'],
      displayName: json['displayName'],
      email: json['email'],
    );
  }
}
