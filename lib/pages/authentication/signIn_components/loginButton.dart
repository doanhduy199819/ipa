// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
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
    return !isLoading
        ? Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0),
                  height: 48.0,
                  child: ElevatedButton(
                    style: roundedButtonStyle,
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      UserCredential? result = await AuthService()
                          .signInWithEmailAndPassword(
                              widget.email, widget.password);
                      debugPrint(
                          "Email: ${widget.email}', Password: '${widget.password}'");
                      setState(() {
                        isLoading = false;
                      });
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
        : Center(child: CircularProgressIndicator());
  }
}
