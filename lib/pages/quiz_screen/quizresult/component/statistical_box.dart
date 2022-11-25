import 'package:flutter/material.dart';
import '../../controller/question_controller.dart';
import '../../quiz/object/color_quiz_theme.dart';

class StatisticalBox extends StatelessWidget {
  const StatisticalBox({Key? key}) : super(key: key);
  Widget statisticalCustom(Color textColor, String number, String name) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 5,
              width: 5,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: textColor, borderRadius: BorderRadius.circular(50)),
            ),
            Text(number,
                style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontFamily: "RobotoSlab",
                    decoration: TextDecoration.none))
          ],
        ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 1,
            width: 15,
          ),
          Text(
            name,
            style: TextStyle(
                decoration: TextDecoration.none,
                color: ColorQuizTheme()
                    .list[ColorQuizTheme.index]
                    .textQuestionColor,
                fontWeight: FontWeight.w400,
                fontSize: 14),
          )
        ])
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          statisticalCustom(
              ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor,
              (QuesionController.process * 100).toString() + "%",
              "Completation"),
          Spacer(),
          statisticalCustom(
              Colors.green,
              QuesionController().getNumberAnswersCorrect().toString(),
              "Correct"),
          Spacer()
        ],
      ),
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          statisticalCustom(
              ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor,
              QuesionController.numberQuestion.toString(),
              "Total Question"),
          Spacer(),
          statisticalCustom(Colors.redAccent,
              QuesionController().getNumberAnswersWrong().toString(), "Wrong"),
          Spacer()
        ],
      ),
      Spacer()
    ]);
  }
}
