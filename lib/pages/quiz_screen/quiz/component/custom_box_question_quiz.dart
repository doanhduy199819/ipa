import 'package:flutter/material.dart';
import '../../quiz/component/option.dart';
import '../../controller/question_controller.dart';
import '../../quiz/object/color_quiz_theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../object/question.dart';

class CustomQuestionQuiz extends StatefulWidget {
  const CustomQuestionQuiz({Key? key}) : super(key: key);

  @override
  State<CustomQuestionQuiz> createState() => _CustomQuestionQuizState();
}

class _CustomQuestionQuizState extends State<CustomQuestionQuiz> {
  Color backgroundColor =
      ColorQuizTheme().list[ColorQuizTheme.index].backgroundQuestionColor;
  Color textColor =
      ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor;
  Question question = QuesionController.listQuestion![QuesionController.index];
  int numberQuestion = QuesionController.numberQuestion;
  double proccess = QuesionController.process;
  double radiusCircle = 35;
  @override
  Widget build(BuildContext context) {
    backgroundColor =
        ColorQuizTheme().list[ColorQuizTheme.index].backgroundQuestionColor;
    textColor = ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor;
    question = QuesionController.listQuestion![QuesionController.index];
    numberQuestion = QuesionController.numberQuestion;
    proccess = QuesionController.process;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child:
          Column(children: [BoxQuestion(context), ListBoxQuestion(context, 0)]),
    );
  }

  Container ListBoxQuestion(BuildContext context, int myAnswer) {
    List<Widget> listboxquestion = [];
    for (int i = 0; i < question.answers!.length; i++) {
      InkWell inkWell = InkWell(
        child: Option(
          content: question.answers![i]!,
          correct: QuesionController().checkStatusAnswerOption(i),
        ),
        onTap: (() {
          if (QuesionController.myAnswers[QuesionController.index] == -1) {
            setState(() {
              QuesionController().increaseProcess();
              QuesionController.myAnswers[QuesionController.index] = i;
            });
          }
        }),
      );
      listboxquestion.add(inkWell);
    }
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h - (270 + radiusCircle + 160),
      child: SingleChildScrollView(
        child: Column(
          children: listboxquestion,
        ),
      ),
    );
  }

  Stack BoxQuestion(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Container boxQuestion = Container(
        margin: EdgeInsets.only(top: radiusCircle, bottom: 20),
        height: 250,
        width: size.width,
        padding: EdgeInsets.only(
            left: 15, bottom: 20, right: 15, top: radiusCircle + 5),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(2.5, 5),
                blurRadius: 4.0,
                spreadRadius: 4.0,
              )
            ]),
        child: SingleChildScrollView(
          child: Text(
            question.question.toString(),
            style: TextStyle(
              decoration: TextDecoration.none,
              color: textColor,
              fontSize: 14,
              fontFamily: "RobotoSlab",
            ),
          ),
        ));
    return Stack(
      children: [
        boxQuestion,
        Align(child: CustomCircleProccess(context, radiusCircle))
      ],
    );
  }

  Container CustomCircleProccess(BuildContext context, double radius) {
    Color color = Color.fromRGBO(209, 204, 231, 1);
    if (backgroundColor == Color.fromRGBO(36, 25, 49, 1)) color = Colors.grey;
    return Container(
      height: radius * 2,
      width: radius * 2,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(50)),
      child: CircularPercentIndicator(
        radius: radius,
        lineWidth: 8.0,
        animation: true,
        percent: proccess,
        center: new Text(
          (QuesionController.index + 1).toString(),
          style: new TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: textColor),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Color.fromRGBO(209, 204, 231, 1),
        progressColor: Color.fromRGBO(157, 117, 203, 1),
      ),
    );
  }
}
