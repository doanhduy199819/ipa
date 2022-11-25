import 'package:flutter/material.dart';
import '../../controller/question_controller.dart';
import '../../quizresult/quiz_result.dart';

class BottomBar {
  BoxDecoration decoration(Color backgroundColor) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(5),
    );
  }

  Container hintButton(Color backgroundColor, Color textColor) {
    return Container(
        height: 50,
        width: 50,
        decoration: decoration(backgroundColor),
        margin: EdgeInsets.only(left: 20, bottom: 5),
        child: Icon(
          Icons.emoji_objects_outlined,
          size: 24,
          color: textColor,
        ));
  }

  Container backButton(Color backgroundColor, Color textColor) {
    return Container(
        height: 50,
        width: 50,
        decoration: decoration(backgroundColor),
        margin: EdgeInsets.only(left: 20, bottom: 5),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 14,
          color: textColor,
        ));
  }

  TextStyle textStyle(Color textColor) {
    return TextStyle(color: textColor, fontSize: 16);
  }

  Container nextButton(double width, Color backgroundColor, Color textColor) {
    return Container(
      height: 50,
      // MediaQuery.of(context).size.width - 100
      width: width,
      decoration: decoration(backgroundColor),
      margin: EdgeInsets.only(left: 10, bottom: 5),
      child: Align(
          child: Text(
        "NEXT",
        style: textStyle(textColor),
      )),
    );
  }

  Container submitButton(double width, Color backgroundColor, Color textColor) {
    return Container(
      height: 50,
      // MediaQuery.of(context).size.width - 100
      width: width,
      decoration: decoration(backgroundColor),
      margin: EdgeInsets.only(left: 10, bottom: 5),
      child: Align(
          child: Text(
        "SUBMIT",
        style: textStyle(textColor),
      )),
    );
  }

  Container firstButton(Color backgroundColor, Color textColor) {
    if (QuesionController.index == 0)
      return hintButton(backgroundColor, textColor);
    return backButton(backgroundColor, textColor);
  }

  Container secondButton(double width, Color backgroundColor, Color textColor) {
    if (QuesionController.index == QuesionController.numberQuestion - 1)
      return submitButton(width, backgroundColor, textColor);
    return nextButton(width, backgroundColor, textColor);
  }

  void onTagFirstButton() {
    if (QuesionController.index == 0) {
      //
    } else
      QuesionController.index = QuesionController.index - 1;
  }

  void onTagSecondButton(BuildContext context) {
    if (QuesionController.index == QuesionController.numberQuestion - 1) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QuizResult()),
      );
    } else
      QuesionController.index = QuesionController.index + 1;
  }
}
