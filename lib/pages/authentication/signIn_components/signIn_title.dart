import 'package:flutter/material.dart';

class buildSignInTitle extends StatelessWidget {
  const buildSignInTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Text(
        'SIGN IN',
        style: TextStyle(
          fontSize: 52.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
