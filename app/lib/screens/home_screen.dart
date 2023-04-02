import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/components/self_metrics.dart';
import 'package:workspaces/services/firestore_service.dart';
import 'package:workspaces/widgets/hot_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HotButton(
            onPressed: () {
              context.read<FirestoreService>().logWorkout(context);
            },
            child: Text(
              "LOG WORKOUT",
              style: GoogleFonts.kumbhSans(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 30),
          const SelfMetrics(),
        ],
      ),
    );
  }
}
