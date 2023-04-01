import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/hot_user.dart';
import 'package:workspaces/components/hot_button.dart';
import 'package:workspaces/services/auth_service.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var hotuser = context.watch<HotUser?>();
    return Scaffold(
      body: Center(
        child: HotButton(
          onPressed: () {
            context.read<AuthService>().signOut();
          },
          child: Text(
            "SIGN OUT",
            style: GoogleFonts.asap(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
