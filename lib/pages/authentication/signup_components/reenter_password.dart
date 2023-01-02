import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildReenterPassword extends StatelessWidget {
  const buildReenterPassword({
    Key? key,
    required this.reenterPasswordOnChanged,
    required this.reenterPasswordValidator,
    required this.password,
  }) : super(key: key);

  final String password;
  final Function(String)? reenterPasswordOnChanged;
  final String? Function(String?)? reenterPasswordValidator;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      mainColor: Colors.blue.shade900,
      iconData: Icons.key_rounded,
      textColor: Colors.black,
      hintText: 'Re-enter Password',
      hintTextColor: Colors.black,
      obscureText: true,
      onChanged: reenterPasswordOnChanged,
      validator: reenterPasswordValidator ?? _validatorReenterPassword,
    );
  }

  String? _validatorReenterPassword(String? reenterPassword) {
    debugPrint('validator call ${password} ${reenterPassword}');
    if (password.compareTo(reenterPassword ?? '') != 0) {
      return 'Password does not match';
    }
    return null;
  }
}
