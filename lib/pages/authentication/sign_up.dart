// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/register_button.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/signup_title.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import '../../services/auth_service.dart';
import 'signup_components/display_name.dart';
import 'signup_components/reenter_password.dart';
import 'signup_components/signup_email.dart';
import 'signup_components/signup_password.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  String? reEnterPassword;
  String? displayName;
  final _auth = AuthService();
  final _formStateKey = GlobalKey<FormState>();

  final backgroundImage = AssetImage("assets/images/signUp_background.jpg");

  final signUpBackground = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(255, 66, 140, 182),
        Color.fromARGB(255, 15, 6, 154),
      ],
    ),
  );

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: signUpBackground,
        child: ListView(
          children: [
            const buildSignUpTitle(),
            Form(
              key: _formStateKey,
              child: buildInfoBox(
                emailOnChanged: (value) => setState(() => email = value),
                passwordOnChanged: (value) => setState(() => password = value),
                reenterPasswordOnChanged: (value) =>
                    setState(() => reEnterPassword = value),
                displayNameOnChanged: (value) =>
                    setState(() => displayName = value),
                password: password ?? '',
                emailOnEditingComplete: () {
                  // TODO: To check before user press Sign up button
                },
              ),
            ),
            const SizedBox(height: 16.0),
            buildRegisterButton(
              email: email ?? '',
              password: password ?? '',
              reenterPassword: reEnterPassword ?? '',
              displayName: displayName ?? '',
              validate: () {
                if (_formStateKey.currentState!.validate()) {
                  // TODO: SIGN UP HERE
                  AuthService()
                      .signUpWithDisplayName(email, password, displayName);
                }
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class buildInfoBox extends StatelessWidget {
  const buildInfoBox({
    Key? key,
    this.emailOnChanged,
    this.passwordOnChanged,
    this.reenterPasswordOnChanged,
    this.displayNameOnChanged,
    //
    this.emailValidator,
    this.passwordValidator,
    this.reenterPasswordValidator,
    this.displayNameValidator,
    //
    required this.password,
    this.emailOnEditingComplete,
  }) : super(key: key);

  final Function(String)? emailOnChanged;
  final Function(String)? passwordOnChanged;
  final Function(String)? reenterPasswordOnChanged;
  final Function(String)? displayNameOnChanged;

  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;
  final String? Function(String?)? reenterPasswordValidator;
  final String? Function(String?)? displayNameValidator;

  final String password;
  final Function()? emailOnEditingComplete;

  @override
  Widget build(BuildContext context) {
    final blurBackground = BoxDecoration(
        color: Colors.white70.withOpacity(0.2),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)));

    return Container(
      decoration: blurBackground,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildEmail(
            emailOnChanged: emailOnChanged,
            emailValidator: emailValidator,
            emailOnEditingComplete: emailOnEditingComplete,
          ),
          const SizedBox(height: 8.0),
          buildPassword(
              passwordOnChanged: passwordOnChanged,
              passwordValidator: passwordValidator),
          const SizedBox(height: 8.0),
          buildReenterPassword(
              password: password,
              reenterPasswordOnChanged: reenterPasswordOnChanged,
              reenterPasswordValidator: reenterPasswordValidator),
          const SizedBox(height: 8.0),
          buildDisplayName(
              displayNameOnChanged: displayNameOnChanged,
              displayNameValidator: displayNameValidator),
        ],
      ),
    );
  }
}