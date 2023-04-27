import 'package:flutter/material.dart';
import 'package:workspaces/components/self_metrics.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 50),
            SelfMetrics(),
          ],
        ),
      ),
    );
  }
}
