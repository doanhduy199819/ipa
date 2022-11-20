import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../quiz/quiz.dart';
import '../quizdescription/achievement_widget.dart';
import '../quizdescription/back_arrow.dart';
import '../quizdescription/background_quiz_discription.dart';
import '../quizdescription/big_text_in_achievement.dart';
import '../quizdescription/button_start_quiz.dart';
import '../quizdescription/circle_avatar.dart';
import '../quizdescription/content_description.dart';

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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          // Avatar Circle
                          const CircleAvatarWidget(),
                          //Name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Trong Huy',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  'OVERVIEW',
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontFamily: 'Nunito'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12.0),
                            child: Row(
                              children: [
                                // Number of quiz
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 100,
                                    decoration: AchievementBoxDecoration(),
                                    child: Column(
                                      children: [
                                        //Crown Image
                                        Row(
                                          children: [
                                            AchievementWidget(
                                                imgInAchievementBoxDecor:
                                                    ImgInAchievementBoxDecor(
                                                        imgCrownPath)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12.0,
                                              right: 12.0,
                                              top: 4.0),
                                          child: Row(
                                            children: [
                                              BigTextInAchievement(
                                                  frontText: numberOfQuizz,
                                                  behindText: 'Quizz'),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            Expanded(
                                              flex: 1,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                child: Text(
                                                  'Number of quiz ',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 100,
                                    decoration: AchievementBoxDecoration(),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            AchievementWidget(
                                                imgInAchievementBoxDecor:
                                                    ImgInAchievementBoxDecor(
                                                        imgTroyphyPath)),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0, top: 4.0),
                                          child: Row(
                                            children: [
                                              BigTextInAchievement(
                                                  frontText: yourHighestScores
                                                      .toString(),
                                                  behindText:
                                                      '/$maxScoresOfQuizz'),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.0),
                                                child: Text(
                                                  'Your highest scores',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  'DESCRIPTION',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    //  fontFamily: 'Nunito',
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                              child: Row(
                                children: const [
                                  Spacer(),
                                  ButtonStartQuizWidget(),
                                  Spacer(),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Quiz()),
                                );
                              },
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
      ),
    );
  }

  BoxDecoration ImgInAchievementBoxDecor(String imgPath) {
    return BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        //image: AssetImage('assets/icons/bgg.jpg'),
        image: AssetImage(imgPath),
        fit: BoxFit.fill,
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.yellow,
          blurRadius: 8.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    );
  }

  BoxDecoration AchievementBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(238, 239, 241, 1),
          blurRadius: 15,
          spreadRadius: 8,
          offset: Offset(5.0, 8.0),
        ),
      ],
    );
  }
}
