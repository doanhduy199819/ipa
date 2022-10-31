import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class buildExtraLoginMethods extends StatelessWidget {
  const buildExtraLoginMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SignInButton(
          Buttons.GoogleDark,
          onPressed: () => AuthService().signInWithGoogleEmail(),
        ),
        const SizedBox(height: 16.0),
        SignInButton(
          Buttons.Apple,
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          onPressed: () => AuthService().signInAnonymous(),
        ),
        const SizedBox(height: 16.0),
        SignInButton(
          Buttons.GitHub,
          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          onPressed: () => AuthService().signInAnonymous(),
        ),
      ],
    );
  }
}
