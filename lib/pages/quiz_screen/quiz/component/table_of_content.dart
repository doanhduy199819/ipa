import 'package:flutter/material.dart';
import '../../quiz/component/option.dart';
import '../../controller/question_controller.dart';
import '../../quiz/object/color_quiz_theme.dart';

class AllQuestionDrawer extends StatelessWidget {
  const AllQuestionDrawer({Key? key, required this.index}) : super(key: key);

  final int index;

  int checkStatusQuestion() {
    return QuesionController().checkStatusAnswerQuestion(index);
  }

  Container IconStatusQuestion() {
    int correct = checkStatusQuestion();
    Color color = Colors.green;
    IconData iconData = Icons.check_circle;
    if (correct == -1) {
      color = Colors.red;
      iconData = Icons.cancel;
    }
    return Container(
      height: 12,
      width: 12,
      margin: EdgeInsets.all(3),
      child: (correct == 1 || correct == -1)
          ? Icon(
              iconData,
              color: color,
              shadows: [
                BoxShadow(
                  color: color,
                  blurRadius: 4.0,
                  spreadRadius: 4.0,
                )
              ],
              size: 18,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor =
        ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor;
    Color backgroundColor =
        ColorQuizTheme().list[ColorQuizTheme.index].backgroundQuestionColor;
    Color textQuestionColor =
        ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor;

    return Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          color: boxColor, borderRadius: BorderRadius.circular(5)),
      child: Stack(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(50)),
          child: Align(
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: textQuestionColor),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconStatusQuestion(),
        )
      ]),
    );
  }
}
