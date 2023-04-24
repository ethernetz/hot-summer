import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/onboarding.dart';
import 'package:workspaces/services/auth_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  static Route<dynamic> route() {
    return CupertinoPageRoute(
      builder: (BuildContext context) {
        return const AuthScreen();
      },
      settings: const RouteSettings(name: '/auth'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: const AuthGuard(),
          ),
        ),
      ),
    );
  }
}

class AuthGuard extends StatefulWidget {
  const AuthGuard({super.key});

  @override
  State<AuthGuard> createState() => _AuthGuardState();
}

class _AuthGuardState extends State<AuthGuard> {
  HotUser? _previousHotUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final hotUser = Provider.of<HotUser?>(context);

    if (!(_previousHotUser?.isOnboarded() ?? false) &&
        (hotUser?.isOnboarded() ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }

    _previousHotUser = hotUser;
  }

  @override
  Widget build(BuildContext context) {
    var firebaseUser = context.watch<User?>();
    var hotUser = context.watch<HotUser?>();
    if (firebaseUser == null) {
      if (FirebaseAuth.instance.currentUser == null) {
        context.read<AuthService>().signInAnonymously();
      }
      return const Text("splash");
    }

    if (hotUser == null) {
      return const Text("loading your profile...");
    }

    if (!hotUser.isOnboarded()) {
      return const Onboarding();
    }

    return const Text("taking you to the home screen...");
  }
}
