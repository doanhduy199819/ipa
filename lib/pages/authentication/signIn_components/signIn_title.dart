import 'package:flutter/material.dart';

class buildSignInTitle extends StatelessWidget {
  const buildSignInTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: const Text(
          'SIGN IN',
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
