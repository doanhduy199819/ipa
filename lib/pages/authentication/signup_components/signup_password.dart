import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildPassword extends StatelessWidget {
  const buildPassword({
    Key? key, this.onChanged,
  }) : super(key: key);

  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      hintText: 'Password',
      prefixIcon: Icon(Icons.person_rounded),
      onChanged: onChanged,
      validator: _validatePassword,
    );
  }

  String? _validatePassword(val) {
    if (val != null && val.length < 8) {
      return 'Your password must contain at least 8 characters';
    }
  }
}
