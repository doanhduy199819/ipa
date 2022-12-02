import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz_overview/quiz_overview.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quizresult/component/background_quiz_result.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quizresult/component/statistical_box.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../services/auth_service.dart';
import '../../../../services/database_service.dart';
import '../../controller/question_controller.dart';
import '../../quiz/object/color_quiz_theme.dart';
import '../../quiz/quiz.dart';

class SelectionBloc extends StatelessWidget {
  final _screenshotController = ScreenshotController();
  String name="";
  String topic="";

  SelectionBloc({Key? key}) : super(key: key);

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

  Future<String?> loadName() async {
    if (await DatabaseService().checkUserExits() == false) return "Incognito";
    return AuthService().currentUser?.displayName.toString();
  }

  Stack backGround(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      WavyHeader(
        color: Colors.white.withOpacity(0.2),
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5 + 30),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.5),
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5 + 10),
      ),
      WavyHeader(
        color: Colors.white,
        circle: Circle(
            offSet: Offset(size.width / 2, size.height / 4),
            radius: size.width / 5),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(
            offSet: Offset(size.width * 0.8, size.height * 0.1), radius: 25),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(offSet: Offset(size.width / 2, 0), radius: 50),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle: Circle(offSet: Offset(0, size.height * 0.1), radius: 80),
      ),
      WavyHeader(
        color: Colors.white.withOpacity(0.1),
        circle:
        Circle(offSet: Offset(size.width, size.height * 0.4), radius: 80),
      ),
    ]);
  }
  void _takeScreenshot(Size size, BuildContext context) async {

    await _screenshotController
        .captureFromWidget(Stack(children: [
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
          Stack(children: [backGround(context), textYourScore(size)])),
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
      ])
    ]))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path],text: "Can you beat");
      }
    });

  }


  FutureBuilder textYourScore(Size size) {
    return FutureBuilder(
        future: loadName(),
        builder: (context,  snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            name=snapshot.data.toString();
            return Container(
                width: size.width * 0.4,
                padding: EdgeInsets.only(top: 30),
                margin: EdgeInsets.only(
                    top: size.height / 4 - size.width / 5,
                    left: size.width / 2 - size.width / 5),
                child: Column(
                    children: [
                  Center(
                    child: Text(name+ "'s\n Score",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: ColorQuizTheme()
                                .list[ColorQuizTheme.index]
                                .circleHeaderColor,
                            fontFamily: "RobotoSlab",
                            fontSize: 18)),
                  ),
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
          return Center(child: CircularProgressIndicator());
        });
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
                QuesionController().startQuiz(
                    QuesionController.dataBoxCategories,
                    QuesionController.setOfQuiz);
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
              })),
      Expanded(
          flex: 1,
          child: GestureDetector(
              child: CustomBloc(Icons.share_rounded, "Share"),
              onTap: () {
                _takeScreenshot(MediaQuery.of(context).size,context);
              })),
      SizedBox(width: 20)
    ]);
  }
}
