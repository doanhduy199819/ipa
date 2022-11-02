import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildDisplayName extends StatelessWidget {
  const buildDisplayName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      hintText: 'Display Name',
      prefixIcon: Icon(Icons.person),
    );
  }
}
