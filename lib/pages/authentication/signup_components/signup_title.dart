import 'package:flutter/material.dart';

class buildSignUpTitle extends StatelessWidget {
  const buildSignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
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
