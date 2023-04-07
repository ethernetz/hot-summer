import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/self_metrics.dart';
import 'package:workspaces/components/workout_button.dart';
import 'package:workspaces/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const WorkoutButton(),
            const SizedBox(height: 30),
            const SelfMetrics(),
            const SizedBox(height: 200),
            ElevatedButton(
              onPressed: () {
                context.read<AuthService>().signOut();
              },
              child: const Text('sign out'),
            )
          ],
        ),
      ),
    );
  }
}
