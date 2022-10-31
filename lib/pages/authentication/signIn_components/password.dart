import 'dart:js';

import 'package:flutter/material.dart';

class buildPassword extends StatefulWidget {
  const buildPassword({
    Key? key,
    required this.mainColor,
    this.onChanged,
  }) : super(key: key);

  final Color mainColor;
  final Function(String)? onChanged;

  @override
  State<buildPassword> createState() => _buildPasswordState();
}

class _buildPasswordState extends State<buildPassword> {
  final Icon passwordIcon = const Icon(Icons.key_rounded, color: Colors.blue);

  Icon revealIcon =
      const Icon(Icons.remove_red_eye_rounded, color: Colors.blue);

  final String hintText = 'Password';

  final boxDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  bool isPasswordShown = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: boxDecoration,
      child: Row(
        children: [
          passwordIcon,
          SizedBox(
            width: 8.0,
          ),
          SizedBox(
            width: 240.0,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black)),
              style: TextStyle(color: Colors.black),
              onChanged: widget.onChanged,
              obscureText: isPasswordShown,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordShown = !isPasswordShown;
                    });
                  },
                  icon: revealIcon),
            ],
          )
        ],
      ),
    );
  }
}
