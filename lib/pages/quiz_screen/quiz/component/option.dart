import 'package:flutter/material.dart';

import '../object/color_quiz_theme.dart';

class Option extends StatelessWidget {
  Option({Key? key, required this.content, required this.correct})
      : super(key: key);

  Color backgroundColor =
      ColorQuizTheme().list[ColorQuizTheme.index].backgroundQuestionColor;
  Color textColor =
      ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor;
  final String content;
  final int correct;

  Container NoAnswer() {
    return Container(
      height: 16,
      width: 16,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.grey)),
    );
  }

  Container Answer() {
    return Container(height: 16, width: 16);
  }

  Container WrongAnswer() {
    return Container(
        height: 16,
        width: 16,
        child: Icon(
          Icons.cancel,
          color: Colors.red,
          shadows: [
            BoxShadow(
              color: Colors.red.withOpacity(0.1),
              offset: Offset(2.5, 5),
              blurRadius: 4.0,
              spreadRadius: 4.0,
            )
          ],
        ));
  }

  Container CorrectAnswer() {
    return Container(
        height: 16,
        width: 16,
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          shadows: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              offset: Offset(2.5, 5),
              blurRadius: 4.0,
              spreadRadius: 4.0,
            )
          ],
        ));
  }

  Container IconOption() {
    if (correct == 1) return CorrectAnswer();
    if (correct == -1) return WrongAnswer();
    if (correct == 2) return NoAnswer();
    return Answer();
  }

  BoxDecoration boxDecoration() {
    Color color = Colors.grey;
    if (correct == 1) color = Colors.lightGreenAccent;
    if (correct == -1) color = Colors.redAccent;
    return BoxDecoration(
        color: backgroundColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            offset: Offset(2.5, 5),
            blurRadius: 4.0,
            spreadRadius: 2.0,
          )
        ],
        border: Border.all(color: color.withOpacity(0.5)));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        decoration: boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: size.width - 106,
                child: Text(
                  content,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: textColor,
                    fontSize: 14,
                  ),
                )),
            IconOption(),
          ],
        ));
  }
}
