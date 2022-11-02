import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildEmail extends StatelessWidget {
  const buildEmail({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      hintText: 'Email',
      prefixIcon: Icon(Icons.email_rounded),
      onChanged: onChanged,
      validator: _validateEmail,
    );
  }

  String? _validateEmail(val) {
    if (val == null || val.isEmpty) {
      return 'Enter an email';
    } else {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!(regex.hasMatch(val!))) return "Invalid Email";
    }
  }
}
