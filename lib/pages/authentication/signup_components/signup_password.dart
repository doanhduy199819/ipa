import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildPassword extends StatelessWidget {
  const buildPassword({
    Key? key,
    required this.passwordOnChanged,
    required this.passwordValidator,
  }) : super(key: key);

  final Function(String p1)? passwordOnChanged;
  final String? Function(String? p1)? passwordValidator;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      mainColor: Colors.blue.shade900,
      iconData: Icons.key_rounded,
      textColor: Colors.black,
      hintText: 'Password',
      hintTextColor: Colors.black,
      onChanged: passwordOnChanged,
      obscureText: true,
      validator: passwordValidator ?? _validatePassword,
    );
  }

  String? _validatePassword(String? password) {
    if ((password?.length ?? 0) < 8) {
      return 'Password must contain at least 8 characters';
    }
    return null;
  }
}
