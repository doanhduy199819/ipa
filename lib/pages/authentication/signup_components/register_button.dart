// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class buildRegisterButton extends StatefulWidget {
  buildRegisterButton({
    Key? key,
    required this.email,
    required this.password,
    required this.reenterPassword,
    required this.validate,
    required this.displayName,
  }) : super(key: key);

  final String email;
  final String password;
  final String reenterPassword;
  final String displayName;
  final void Function() validate;

  @override
  State<buildRegisterButton> createState() => _buildRegisterButtonState();
}

class _buildRegisterButtonState extends State<buildRegisterButton> {
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
                      // TODO: check signUpWihtEmailAndPassword

                      User? result = await AuthService().signUpWithDisplayName(
                          widget.email, widget.password, widget.displayName);
                      debugPrint(
                          "Email: ${widget.email}, Password: ${widget.password}, DisplayName: ${widget.displayName}");
                      widget.validate();
                      setState(() {
                        isLoading = false;
                      });
                      if (result != null) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Sign up',
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
