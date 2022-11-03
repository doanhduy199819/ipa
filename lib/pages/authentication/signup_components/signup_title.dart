import 'package:flutter/material.dart';

class buildSignUpTitle extends StatelessWidget {
  const buildSignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
