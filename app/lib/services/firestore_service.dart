import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  FirestoreService(this._firebaseFirestore);

  Future logWorkout(BuildContext context) {
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
