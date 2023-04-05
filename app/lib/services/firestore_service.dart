import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/onboarding_question.dart';
import 'package:workspaces/classes/workouts.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreService(this._firebaseFirestore);

  Future<void> completeOnboarding(
      BuildContext context, List<OnboardingQuestion> question) {
    var hotuser = context.read<HotUser?>();
    if (hotuser == null) {
      return Future.value();
    }
    final sessionsPerWeekGoal = question[1].selectionIndex! + 1;
    return _firebaseFirestore.collection('users').doc(hotuser.uid).update({
      'sessionsPerWeekGoal': sessionsPerWeekGoal,
    });
  }

  Future<void> logWorkout(BuildContext context) {
    var hotuser = context.read<HotUser?>();
    var workouts = context.read<Workouts>();
    if (hotuser == null) {
      return Future.value();
    }
    if (hotuser.sessionsPerWeekGoal == null) {
      return Future.value();
    }

    final userRef = _firebaseFirestore.collection('users').doc(hotuser.uid);
    final userNewWorkoutRef = userRef.collection('workouts').doc();

    return Future.wait([
      userRef.update({
        "streak": _shouldContinueStreak(workouts) ? hotuser.streak + 1 : 1,
      }),
      userNewWorkoutRef.set({
        "timestamp": Timestamp.now(),
      })
    ]);
  }

  bool _shouldContinueStreak(Workouts workouts) {
    final latestWorkout =
        workouts.workouts.isNotEmpty ? workouts.workouts.first : null;
    if (latestWorkout == null) return false;
    return latestWorkout.timestamp.seconds + const Duration(days: 3).inSeconds >
        Timestamp.now().seconds;
  }
}
