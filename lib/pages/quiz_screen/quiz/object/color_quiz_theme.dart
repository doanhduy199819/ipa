import 'package:flutter/material.dart';

class CustomeColorQuiz {
  Color bodyColor;
  Color circleHeaderColor;
  Color backgroundQuestionColor;
  Color textQuestionColor;
  CustomeColorQuiz(this.bodyColor, this.circleHeaderColor,
      this.backgroundQuestionColor, this.textQuestionColor);
}

class CustomColorQuizTheme {
  CustomeColorQuiz lightThemeColor = CustomeColorQuiz(
      Color.fromRGBO(204, 201, 219, 1),
      Color.fromRGBO(160, 161, 226, 1),
      Colors.grey.shade100,
      Colors.black);
  CustomeColorQuiz darkThemeColor = CustomeColorQuiz(
      Color.fromRGBO(22, 12, 37, 1),
      Color.fromRGBO(155, 82, 215, 1),
      // Color.fromRGBO(160, 161, 226, 1),
      Color.fromRGBO(36, 25, 49, 1),
      // Colors.black,
      Colors.white);
}

class ColorQuizTheme {
  List<CustomeColorQuiz> list = [
    CustomColorQuizTheme().lightThemeColor,
    CustomColorQuizTheme().darkThemeColor
  ];
  static int index = 0;
  void changeColorQuizTheme() {
    index = 1 - index;
  }
}
