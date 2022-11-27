import 'package:flutter/material.dart';

import '../../controller/question_controller.dart';
import '../../quiz/object/color_quiz_theme.dart';
import '../../quiz/quiz.dart';

class SelectionBloc extends StatelessWidget {
  const SelectionBloc({Key? key}) : super(key: key);

  Container CustomBloc(IconData iconData, String name) {
    return Container(
        child: Align(
            child: Column(children: [
      Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color:
                ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor,
            borderRadius: BorderRadius.circular(50)),
        child: Icon(iconData,
            color:
                ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor),
      ),
      Text(
        name,
        style: TextStyle(
            decoration: TextDecoration.none,
            color:
                ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      )
    ])));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(width: 20),
      Expanded(
          flex: 1,
          child: GestureDetector(
              child: CustomBloc(Icons.auto_mode_rounded, "Play again"),
              onTap: () {
                Navigator.pop(context);
                QuesionController().startQuiz();
                // QuesionController().addDataTemplate();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quiz()),
                );
              })),
      Expanded(
          flex: 1,
          child: GestureDetector(
              child: CustomBloc(Icons.assignment_rounded, "Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              })),
      Expanded(
          flex: 1,
          child: GestureDetector(
              child: CustomBloc(Icons.share_rounded, "Share"),
              onTap: () {
                Navigator.pop(context);
                // Click on share ...
              })),
      SizedBox(width: 20)
    ]);
  }
}
