import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';

class HotUserProxy extends StatefulWidget {
  final Widget? child;

  const HotUserProxy({super.key, this.child});

  @override
  State<HotUserProxy> createState() => _HotUserProxyState();
}

class _HotUserProxyState extends State<HotUserProxy> {
  Stream<HotUser?> _hotUserStream = const Stream.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var firebaseUser = context.watch<User?>();
    _hotUserStream = getUserStream(firebaseUser);
  }

  Stream<HotUser?> getUserStream(User? firebaseUser) {
    if (firebaseUser == null) {
      return Stream<HotUser?>.value(null);
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .snapshots()
        .map((userDocumentSnapshot) {
      final userData = userDocumentSnapshot.data();
      if (userData == null) {
        return null;
      }
      return HotUser.fromJson(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<HotUser?>.value(
      value: _hotUserStream,
      initialData: null,
      child: widget.child,
    );
  }
}
