import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/onboarding_question.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreService(this._firebaseFirestore);

  Future<void> completeOnboarding(
      BuildContext context, List<OnboardingQuestion> question) {
    var hotuser = context.read<HotUser?>();
    if (hotuser == null) {
      return Future.value();
    }
    return _firebaseFirestore.collection('users').doc(hotuser.uid).update({
      'sessionsPerWeekGoal': question[1].selectionIndex! + 1,
    });
  }

  Future<void> logWorkout(BuildContext context) {
    var hotuser = context.read<HotUser?>();
    if (hotuser == null) {
      return Future.value();
    }
    if (hotuser.sessionsPerWeekGoal == null) {
      return Future.value();
    }
    return _firebaseFirestore.collection('users').doc(hotuser.uid).update(
      {
        'streak': hotuser.streak + 1,
        'sessionsLeft': hotuser.sessionsLeft == 1
            ? hotuser.sessionsPerWeekGoal
            : hotuser.sessionsLeft! - 1,
      },
    );
  }
}
