import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class buildExtraLoginMethods extends StatelessWidget {
  const buildExtraLoginMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () => AuthService().signInWithGoogleEmail(),
            ),
            const SizedBox(height: 4.0),
            TextButton(
              onPressed: () => AuthService().signInAnonymous(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}
