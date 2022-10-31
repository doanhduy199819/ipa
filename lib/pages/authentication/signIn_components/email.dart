import 'package:flutter/material.dart';

class buildEmail extends StatelessWidget {
  const buildEmail({
    Key? key,
    required this.mainColor,
    this.onChanged,
  }) : super(key: key);

  final Color mainColor;
  final Function(String)? onChanged;
  final Icon icon = const Icon(Icons.email_rounded, color: Colors.blue);
  final String hintText = 'Email';
  final boxDecoration = const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      decoration: boxDecoration,
      child: Row(
        children: [
          icon,
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
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
