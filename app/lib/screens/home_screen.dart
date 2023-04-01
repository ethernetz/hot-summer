import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workspaces/components/self_metrics.dart';
import 'package:workspaces/widgets/hot_button.dart';
import 'package:workspaces/services/auth_service.dart';

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
              // context.read<AuthService>().signOut();
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
          SelfMetrics(),
        ],
      ),
    );
  }
}
