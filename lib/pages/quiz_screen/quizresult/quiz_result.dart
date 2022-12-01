import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import '../controller/question_controller.dart';
import '../quiz/object/color_quiz_theme.dart';
import '../quiz/quiz.dart';
import '../quizresult/component/statistical_box.dart';
import 'component/background_quiz_result.dart';
import 'component/selection_bloc.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({Key? key}) : super(key: key);

  Future<String> updateData() async {
    if (await DatabaseService().checkUserExits() == true) {
      if (QuesionController.recentlyQuizId == "") {
        await DatabaseService().addRecentlyQuiz();
        return "add";
      } else {
        await DatabaseService().updateRecentlyQuiz();
        return "Update";
      }
    }
    return "User ko ton tai";
  }

  @override
  Widget build(BuildContext context) {
    print(QuesionController.myAnswers);
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: updateData(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            debugPrint(snapshot.data.toString());
            return buildItem(size, context);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Stack buildItem(Size size, BuildContext context) {
    return Stack(children: [
      Container(
          height: size.height,
          width: size.width,
          color: ColorQuizTheme().list[ColorQuizTheme.index].bodyColor),
      Container(
          height: size.height / 2,
          width: size.width,
          decoration: BoxDecoration(
              color:
                  ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor,
              borderRadius: BorderRadius.circular(15)),
          child:
              Stack(children: [BackgroundQuizResult(), textYourScore(size)])),
      Column(children: [
        Container(
            margin: EdgeInsets.only(top: 50, left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: ColorQuizTheme()
                          .list[ColorQuizTheme.index]
                          .textQuestionColor,
                    ),
                    onTap: (() {
                      Navigator.pop(context);
                    })))),
        Container(
            margin: EdgeInsets.only(
              top: size.height * 0.3,
              left: 20,
              right: 20,
              bottom: size.height * 0.1,
            ),
            height: size.height * 0.25,
            width: size.width - 40,
            decoration: BoxDecoration(
                color: ColorQuizTheme()
                    .list[ColorQuizTheme.index]
                    .backgroundQuestionColor,
                borderRadius: BorderRadius.circular(20)),
            child: StatisticalBox()),
        SelectionBloc(),
      ])
    ]);
  }

  Container textYourScore(Size size) {
    return Container(
        width: size.width * 0.4,
        padding: EdgeInsets.only(top: 30),
        margin: EdgeInsets.only(
            top: size.height / 4 - size.width / 5,
            left: size.width / 2 - size.width / 5),
        child: Column(children: [
          Text("Your Score",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: ColorQuizTheme()
                      .list[ColorQuizTheme.index]
                      .circleHeaderColor,
                  fontFamily: "RobotoSlab",
                  fontSize: 18)),
          Text(QuesionController().getScoreQuiz().toString(),
              style: TextStyle(
                decoration: TextDecoration.none,
                color: ColorQuizTheme()
                    .list[ColorQuizTheme.index]
                    .circleHeaderColor,
                fontFamily: "RobotoSlab",
                fontSize: 30,
              ))
        ]));
  }
}
