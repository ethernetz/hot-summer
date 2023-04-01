import 'package:flutter/material.dart';
import 'package:workspaces/widgets/sign_in_with_apple_button.dart';
import 'package:workspaces/widgets/sign_in_with_google_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              SignInWithAppleButton(),
              SizedBox(height: 10),
              SignInWithGoogleButton(),
            ],
          ),
        ),
      ),
    );
  }
}
