import 'package:flutter/material.dart';

class buildPassword extends StatefulWidget {
  const buildPassword({
    Key? key,
    required this.mainColor,
    this.onChanged,
  }) : super(key: key);

  final Color mainColor;
  final Function(String?)? onChanged;

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
      margin: EdgeInsets.only(left: 16.0, right: 16.0),
      padding: EdgeInsets.only(left: 16.0, right: 8.0),
      decoration: boxDecoration,
      child: Stack(alignment: Alignment.centerLeft, children: [
        Row(
          children: [
            passwordIcon,
            const SizedBox(
              width: 8.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(16.0),
                ),
                style: TextStyle(color: Colors.black),
                onChanged: widget.onChanged,
                obscureText: isPasswordShown,
              ),
            ),
          ],
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordShown = !isPasswordShown;
                  });
                },
                icon: revealIcon))
      ]),
    );
  }
}
