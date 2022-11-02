import 'package:flutter/material.dart';
// import 'package:flutter_interview_preparation/pages/authentication/signup_components/signup_email.dart';
// import 'package:flutter_interview_preparation/pages/authentication/signup_components/input_form.dart';
// import 'package:flutter_interview_preparation/pages/authentication/signup_components/reenter_password.dart';
// import 'package:flutter_interview_preparation/pages/authentication/signup_components/signup_title.dart';
import '../../services/auth_service.dart';
// import 'signup_components/display_name.dart';
// import 'signup_components/signup_password.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? email;
  String? password;
  String? reEnterPassword;
  final _auth = AuthService();
  final _formStateKey = GlobalKey<FormState>();
  var signUpBackground = const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('images/signUp_background.jpg'),
      fit: BoxFit.cover,
    ),
  );
  var blurBackground = BoxDecoration(
      color: Colors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.all(Radius.circular(6.0)));
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: signUpBackground,
      child: Column(
        children: [
          // buildSignUpTitle(),
          Container(
            decoration: blurBackground,
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                // buildEmail(
                //     onChanged: (val) => setState(() => email = val ?? '')),
                // buildPassword(
                //     onChanged: (val) => setState(() => password = val ?? '')),
                // builReenterPassword(
                //     onChanged: (val) =>
                //         setState(() => reEnterPassword = val ?? '')),
                // buildDisplayName(),
              ],
            ),
            // child: ,
          )
        ],
      ),
    )));
  }
}




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
