import 'package:flutter/material.dart';
import '../quiz/quiz.dart';
import '../quizdescription/component/achievement_bloc.dart';

import '../quizdescription/component/back_arrow.dart';
import '../quizdescription/component/background_quiz_discription.dart';

import '../quizdescription/component/button_start_quiz.dart';

import '../quizdescription/component/text_function_bloc.dart';
import '../quizdescription/content_description.dart';
import '../quizdescription/top_bloc_description.dart';

class QuizDescription extends StatelessWidget {
  String numberOfQuizz = '30';
  int yourHighestScores = 180;
  int maxScoresOfQuizz = 300;
  String imgCrownPath = 'assets/icons/crown_icon.png';
  String imgTroyphyPath = 'assets/icons/trophy.png';
  QuizDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthOfDevice = MediaQuery.of(context).size.width;
    double heightOfDevice = MediaQuery.of(context).size.height;

    List<String> contentDescription = [
      '- All questions are for 10 marks',
      '- This set of topics will help you review programming skills & knowledge',
      '- You will be more confident in the interview after completing this set of questions'
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // background
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
                          numberOfQuizz: numberOfQuizz,
                          imgTroyphyPath: imgTroyphyPath,
                          yourHighestScores: yourHighestScores,
                          maxScoresOfQuizz: maxScoresOfQuizz,
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
                                contentDescription: contentDescription),
                          ],
                        ),
                        //Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Quiz()),
                              );
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
