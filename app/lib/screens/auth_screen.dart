import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:workspaces/components/sign_in_with_google_button.dart';
import 'package:workspaces/providers/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInWithAppleButton(
              style: SignInWithAppleButtonStyle.black,
              iconAlignment: IconAlignment.center,
              onPressed: () {
                context.read<AuthProvider>().signInWithApple();
              },
            ),
            const SignInWithGoogleButton()
          ],
        ),
      ),
    );
  }
}
