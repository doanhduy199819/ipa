// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class buildLoginButton extends StatefulWidget {
  buildLoginButton({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);

  final String email;
  final String password;

  @override
  State<buildLoginButton> createState() => _buildLoginButtonState();
}

class _buildLoginButtonState extends State<buildLoginButton> {
  final ButtonStyle roundedButtonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))));

  final AuthService _auth = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print('rebuild log in');
    return !isLoading
        ? Row(
            children: [
              Expanded(
                child: Container(
                  height: 60.0,
                  child: ElevatedButton(
                    style: roundedButtonStyle,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      dynamic result = await AuthService()
                          .signInWithEmailAndPassword(
                              widget.email, widget.password);
                      print(
                          "Email: ${widget.email}', Password: '${widget.password}'");
                      setState(() {
                        isLoading = false;
                      });
                      if (result == null) {
                        print('no user');
                        Fluttertoast.showToast(
                            msg: "Your email & password are not correct",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        : CircularProgressIndicator();
  }
}
