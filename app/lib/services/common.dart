import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/classes/workout.dart';

CollectionReference<HotUser?> usersCollectionRef =
    FirebaseFirestore.instance.collection('users').withConverter(
  fromFirestore: (docSnapshot, options) {
    final json = docSnapshot.data();
    if (json == null) return null;
    return HotUser.fromMap(json);
  },
  toFirestore: (HotUser? user, options) {
    if (user == null) return {};
    return user.toFirestore();
  },
);

CollectionReference<Workout> userWorkoutsCollectionRef(String uid) {
  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('workouts')
      .withConverter(
    fromFirestore: (docSnapshot, options) {
      final json = docSnapshot.data();
      return Workout.fromMap(json);
    },
    toFirestore: (Workout? workout, options) {
      if (workout == null) return {};
      return workout.toFirestore();
    },
  );
}
