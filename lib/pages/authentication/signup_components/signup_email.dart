import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildEmail extends StatelessWidget {
  const buildEmail({
    Key? key,
    required this.emailOnChanged,
    required this.emailValidator,
    this.emailOnEditingComplete,
  }) : super(key: key);

  final Function(String)? emailOnChanged;
  final String? Function(String?)? emailValidator;
  final Function()? emailOnEditingComplete;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      mainColor: Colors.blue.shade900,
      iconData: Icons.email_rounded,
      textColor: Colors.black,
      hintText: 'Email',
      hintTextColor: Colors.black,
      onChanged: emailOnChanged,
      validator: emailValidator ?? _validateEmail,
    );
  }

  String? _validateEmail(String? email) {
    bool isvalid = EmailValidator.validate(email ?? '');
    if (!isvalid) return 'Your email is invalid';
    return null;
  }
}
