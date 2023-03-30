import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/services/auth_service.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        minimumSize: const Size.fromHeight(40),
      ),
      onPressed: () {
        context.read<AuthService>().signInWithGoogle();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
              flex: 3,
              child: Image(
                image: AssetImage("assets/google_logo.png"),
                height: 32,
                width: 32,
              ),
            ),
            Expanded(
              flex: 7,
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
