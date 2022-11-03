import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';

class buildDisplayName extends StatelessWidget {
  const buildDisplayName({
    Key? key,
    required this.displayNameOnChanged,
    required this.displayNameValidator,
    this.displayNameOnEditingComplete,
  }) : super(key: key);

  final Function(String)? displayNameOnChanged;
  final String? Function(String?)? displayNameValidator;
  final Function()? displayNameOnEditingComplete;

  @override
  Widget build(BuildContext context) {
    return InputFormWidget(
      mainColor: Colors.blue.shade900,
      iconData: Icons.person_rounded,
      textColor: Colors.black,
      hintText: 'Display Name',
      hintTextColor: Colors.black,
      onChanged: displayNameOnChanged,
      validator: displayNameValidator,
      onEditingComplete: displayNameOnEditingComplete,
    );
  }
}
