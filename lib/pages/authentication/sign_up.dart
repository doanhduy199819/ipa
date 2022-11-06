// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/register_button.dart';
import 'package:flutter_interview_preparation/pages/authentication/signup_components/signup_title.dart';
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
      // resizeToAvoidBottomInset: false,
      body: Container(
        // decoration: BoxDecoration(color: Colors.pink),
        // padding:
        //     EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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

    print('viewPadding ${MediaQuery.of(context).viewPadding.bottom}');
    print('ViewInsets ${MediaQuery.of(context).viewInsets.bottom}');
    print('Padding ${MediaQuery.of(context).padding.bottom}');

    return Container(
      decoration: blurBackground,
      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: 16.0,
      ),
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

// class buildEmail extends StatelessWidget {
//   const buildEmail({
//     Key? key,
//     required this.emailOnChanged,
//     required this.emailValidator,
//   }) : super(key: key);

//   final Function(String p1)? emailOnChanged;
//   final String? Function(String? p1)? emailValidator;

//   @override
//   Widget build(BuildContext context) {
//     return InputFormWidget(
//       mainColor: Colors.blue.shade900,
//       iconData: Icons.email_rounded,
//       textColor: Colors.black,
//       hintText: 'Email',
//       hintTextColor: Colors.black,
//       onChanged: emailOnChanged,
//       validator: emailValidator,
//     );
//   }
// }

// class buildPassword extends StatelessWidget {
//   const buildPassword({
//     Key? key,
//     required this.passwordOnChanged,
//     required this.passwordValidator,
//   }) : super(key: key);

//   final Function(String p1)? passwordOnChanged;
//   final String? Function(String? p1)? passwordValidator;

//   @override
//   Widget build(BuildContext context) {
//     return InputFormWidget(
//       mainColor: Colors.blue.shade900,
//       iconData: Icons.key_rounded,
//       textColor: Colors.black,
//       hintText: 'Password',
//       hintTextColor: Colors.black,
//       onChanged: passwordOnChanged,
//       validator: passwordValidator,
//     );
//   }
// }

// class buildReenterPassword extends StatelessWidget {
//   const buildReenterPassword({
//     Key? key,
//     required this.reenterPasswordOnChanged,
//     required this.reenterPasswordValidator,
//   }) : super(key: key);

//   final Function(String p1)? reenterPasswordOnChanged;
//   final String? Function(String? p1)? reenterPasswordValidator;

//   @override
//   Widget build(BuildContext context) {
//     return InputFormWidget(
//       mainColor: Colors.blue.shade900,
//       iconData: Icons.key_rounded,
//       textColor: Colors.black,
//       hintText: 'Re-enter Password',
//       hintTextColor: Colors.black,
//       onChanged: reenterPasswordOnChanged,
//       validator: reenterPasswordValidator,
//     );
//   }
// }

// class buildDisplayName extends StatelessWidget {
//   const buildDisplayName({
//     Key? key,
//     required this.displayNameOnChanged,
//     required this.displayNameValidator,
//   }) : super(key: key);

//   final Function(String p1)? displayNameOnChanged;
//   final String? Function(String? p1)? displayNameValidator;

//   @override
//   Widget build(BuildContext context) {
//     return InputFormWidget(
//       mainColor: Colors.blue.shade900,
//       iconData: Icons.person_rounded,
//       textColor: Colors.black,
//       hintText: 'Display Name',
//       hintTextColor: Colors.black,
//       onChanged: displayNameOnChanged,
//       validator: displayNameValidator,
//     );
//   }
// }


/*

 // child: Column(
        //   children: [
        //     const buildSignUpTitle(),
        //     Container(
        //       decoration: blurBackground,
        //       margin: EdgeInsets.all(16),
        //       child: Column(
        //         children: [
        //           Text('hello'),
        //           // buildEmail(
        //           //     onChanged: (val) => setState(() => email = val ?? '')),
        //           // buildPassword(
        //           //     onChanged: (val) => setState(() => password = val ?? '')),
        //           // builReenterPassword(
        //           //     onChanged: (val) =>
        //           //         setState(() => reEnterPassword = val ?? '')),
        //           // buildDisplayName(),
        //         ],
        //       ),
        //       // child: ,
        //     )
        //   ],
        // ),

*/



/* 
  Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Email'),
                  hintText: 'example@abc.com',
                ),
                onChanged: (val) => email = val,
                validator: _validateEmail,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Password'),
                  hintText: 'YourPassword123',
                ),
                obscureText: true,
                onChanged: (val) => password = val,
                validator: _validatePassword,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Re-enter password'),
                ),
                obscureText: true,
                validator: _validateReenterPassword,
              ),
              SizedBox(
                height: 20.0,
              ),
              !isLoading
                  ? FlatButton(
                      onPressed: () async {
                        setState(() => isLoading = true);
                        if (_formStateKey.currentState!.validate()) {
                          dynamic result = await _auth.signUp(email, password);
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Register successfully'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Something went wrong'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                        print('Email = ' + email);
                        print('Password = ' + password);
                        setState(() => isLoading = false);
                      },
                      child: Text('Register'),
                      color: Colors.green,
                      textColor: Colors.white,
                    )
                  : CircularProgressIndicator()
            ],
          ),
*/
