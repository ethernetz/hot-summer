import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final Timestamp timestamp;

  const Workout({
    required this.timestamp,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      timestamp: json['timestamp'],
    );
  }
}
