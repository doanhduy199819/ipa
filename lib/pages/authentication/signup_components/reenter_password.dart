import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class builReenterPassword extends StatelessWidget {
  const builReenterPassword({
    Key? key, this.onChanged,
  }) : super(key: key);

  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      hintText: 'Re-enter Password',
      prefixIcon: Icon(Icons.key_rounded),
      onChanged: onChanged,
    );
  }

  String? _validateReenterPassword(reEnterPassword) {
    // if (reEnterPassword != password) {
    //   return "Your password is not the same";
    // }
  }
}
