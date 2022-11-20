import 'package:flutter/material.dart';

class BigTextInAchievement extends StatelessWidget {
  String frontText;
  String behindText;
  BigTextInAchievement({Key? key, required this.frontText, required this.behindText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis, // tràn chữ
      textAlign: TextAlign.start,
      text: TextSpan(
        text: frontText,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          // fontFamily: 'Nunito',
          fontWeight: FontWeight.w500,
          // ignore: prefer_const_literals_to_create_immutables
        ),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          TextSpan(
            text: ' $behindText',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              // fontFamily: 'Nunito',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
