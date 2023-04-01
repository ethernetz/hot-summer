import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/hot_button.dart';
import 'package:workspaces/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hotuser = context.watch<HotUser?>();
    return Column(
      children: [
        Center(
          child: HotButton(
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
        ),
      ],
    );
  }
}
