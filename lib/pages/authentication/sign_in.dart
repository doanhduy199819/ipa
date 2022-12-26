// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/main.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/dont_have_account.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/forgot_password.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/password.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/extra_login.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/loginButton.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/email.dart';
import 'package:flutter_interview_preparation/pages/authentication/signIn_components/signIn_title.dart';
import 'package:flutter_interview_preparation/pages/authentication/sign_up.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  // Sign in state
  String email = "";
  String password = "";

  // Color
  final Color mainColor = Colors.blue.shade600;
  final Color darkThemeMainColor = Colors.white;
  final Color backgroundColor = Colors.blue.shade900;

  // Space between elements
  final SizedBox space = const SizedBox(height: 20.0);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/signIn_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const buildSignInTitle(),
                buildEmail(
                  mainColor: mainColor,
                  onChanged: (val) => setState(() => email = val ?? ''),
                ),
                const SizedBox(height: 16.0),
                buildPassword(
                    mainColor: mainColor,
                    onChanged: (val) => setState(() => password = val ?? '')),
                const SizedBox(height: 16.0),
                buildLoginButton(
                  email: email,
                  password: password,
                ),
                const SizedBox(height: 16.0),
                const Center(
                    child: Text('OR', style: TextStyle(color: Colors.white))),
                const SizedBox(height: 16.0),
                const Center(
                    child: Text('Login With',
                        style: TextStyle(fontSize: 12.0, color: Colors.white))),
                const SizedBox(height: 16.0),
                const buildExtraLoginMethods(),
                const SizedBox(height: 16.0),
                const buildDontHaveAccount(),
                Container(
                  color: Colors.amber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
