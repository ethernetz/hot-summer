import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/onboarding.dart';
import 'package:workspaces/services/auth_service.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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

class AuthGuard extends StatelessWidget {
  const AuthGuard({super.key});
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

    if (hotUser.sessionsPerWeekGoal == null) {
      return const Onboarding();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return const Text("taking you to the home screen...");
  }
}
