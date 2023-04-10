import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/workouts.dart';

import 'common.dart';

class WorkoutsProxy extends StatefulWidget {
  final Widget? child;

  const WorkoutsProxy({super.key, this.child});

  @override
  State<WorkoutsProxy> createState() => _WorkoutsProxyState();
}

class _WorkoutsProxyState extends State<WorkoutsProxy> {
  Stream<Workouts> _hotUserStream = const Stream.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var firebaseUser = context.watch<User?>();
    _hotUserStream = getWorkoutStream(firebaseUser);
  }

  Stream<Workouts> getWorkoutStream(User? firebaseUser) {
    if (firebaseUser == null) {
      return Stream<Workouts>.value(const Workouts(workouts: []));
    }
    return userWorkoutsCollectionRef(firebaseUser.uid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((workoutsSnapshot) =>
            Workouts.fromSnapshots(workoutsSnapshot.docs));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Workouts>.value(
      value: _hotUserStream,
      initialData: const Workouts(workouts: []),
      child: widget.child,
    );
  }
}
