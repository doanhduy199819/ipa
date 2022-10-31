// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class buildForgotPassword extends StatelessWidget {
  const buildForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
            onPressed: () {},
            hoverColor: Colors.blue.shade800,
            child: Text(
              'Forgot Password?',
              style: const TextStyle(
                fontSize: 12.0,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            )),
      ],
    );
  }
}
