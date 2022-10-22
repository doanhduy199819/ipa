import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/authentication/sign_up.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  // Sign in state
  late String email;
  late String password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Sign in to IPA'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Email'),
                  hintText: 'example@abc.com',
                ),
                onChanged: (val) {
                  email = val;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Password'),
                  hintText: 'YourPassword123',
                ),
                obscureText: true,
                onChanged: (val) {
                  password = val;
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () async {
                      print('Email = ' + email);
                      print('Password = ' + password);
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                    },
                    child: Text('Sign in'),
                    color: Colors.pink,
                    textColor: Colors.white,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Register account',
                        style: TextStyle(
                          color: Colors.blue.shade400,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SignInButton(
                Buttons.GoogleDark,
                text: "Sign in with Google",
                onPressed: () {
                  _auth.signInWithGoogleEmail();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
