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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Sign up to IPA'),
      ),
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
                onChanged: (val) {
                  email = val;
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter an email';
                  }
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
                validator: (val) {
                  if (val != null && val.length < 8) {
                    return 'Your password must contain at least 8 characters';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('Re-enter password'),
                ),
                obscureText: true,
                validator: (reEnterPassword) {
                  if (reEnterPassword != password) {
                    return "Your password is not the same";
                  }
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              FlatButton(
                onPressed: () async {
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
                          content: Text('Please enter valid email'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                  print('Email = ' + email);
                  print('Password = ' + password);
                },
                child: Text('Register'),
                color: Colors.green,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
