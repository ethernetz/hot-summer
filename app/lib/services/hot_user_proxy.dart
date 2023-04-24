import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/services/common.dart';

class HotUserProxy extends StatefulWidget {
  final Widget child;

  const HotUserProxy({super.key, required this.child});

  @override
  State<HotUserProxy> createState() => _HotUserProxyState();
}

class _HotUserProxyState extends State<HotUserProxy> {
  Stream<HotUser?> _hotUserStream = const Stream.empty();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var firebaseUser = context.watch<User?>();
    _hotUserStream = getUserStream(firebaseUser).asBroadcastStream();
  }

  Stream<HotUser?> getUserStream(User? firebaseUser) {
    if (firebaseUser == null) {
      return Stream<HotUser?>.value(null);
    }
    return usersCollectionRef
        .doc(firebaseUser.uid)
        .snapshots()
        .map((snapshot) => snapshot.data());
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
