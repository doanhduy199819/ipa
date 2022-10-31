import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/sign_up.dart';

class buildDontHaveAccount extends StatelessWidget {
  const buildDontHaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account ?",
          style: TextStyle(fontSize: 12.0, color: Colors.white),
        ),
        FlatButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUp()),
                ),
            child: Text(
              'Register',
              style: TextStyle(
                  fontSize: 12.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            )),
      ],
    );
  }
}
