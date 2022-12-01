import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/question_controller.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import '../quiz_description/component/achievement_bloc.dart';
import '../quiz/quiz.dart';

import '../quiz_description/component/back_arrow.dart';
import '../quiz_description/component/background_quiz_discription.dart';

import '../quiz_description/component/button_start_quiz.dart';

import '../quiz_description/component/text_function_bloc.dart';
import '../quiz_description/content_description.dart';
import '../quiz_description/top_bloc_description.dart';

class QuizDescription extends StatelessWidget {
  QuizDescription(
      {Key? key, required this.dataBoxCategories, required this.setOfQuiz})
      : super(key: key);

  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;
  String imgCrownPath = 'assets/icons/crown_icon.png';
  String imgTroyphyPath = 'assets/icons/trophy.png';

  @override
  Widget build(BuildContext context) {
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              height: heightOfDevice * 0.25,
              width: widthOfDevice,
              color: Colors.white,
              child: const BackgroundQuizDiscription(),
            ),
            // exit button
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // Back Arrow
                const BackArrowButton(),
              ],
            ),
            Column(
              children: [
                TopBlocDescription(),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24.0),
                          child: TextFuncTionBloc(title: 'OVERVIEW'),
                        ),
                        AchievementBloc(
                          imgCrownPath: imgCrownPath,
                          imgTroyphyPath: imgTroyphyPath,
                          dataBoxCategories: dataBoxCategories,
                          setOfQuiz: setOfQuiz,
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: TextFuncTionBloc(
                              title: 'DESCRIPTION',
                            )),
                        const SizedBox(
                          height: 12,
                        ),
                        // content description
                        Row(
                          children: [
                            ContentDescriptionWidget(
                              widthOfDevice: widthOfDevice,
                              dataBoxCategories: dataBoxCategories,
                              setOfQuiz: setOfQuiz,
                            ),
                          ],
                        ),
                        //Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: InkWell(
                            onTap: () {
                              QuesionController()
                                  .startQuiz(dataBoxCategories, setOfQuiz);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Quiz()));
                            },
                            child: Row(
                              children: const [
                                Spacer(),
                                ButtonStartQuizWidget(),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
