import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  final _auth = AuthService();
  final _formStateKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formStateKey,
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
        ),
      ),
    );
  }

  String? _validateReenterPassword(reEnterPassword) {
    if (reEnterPassword != password) {
      return "Your password is not the same";
    }
  }

  String? _validatePassword(val) {
    if (val != null && val.length < 8) {
      return 'Your password must contain at least 8 characters';
    }
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
