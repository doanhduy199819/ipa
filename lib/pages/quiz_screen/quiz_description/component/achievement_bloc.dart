import 'package:flutter/material.dart';

import '../../../../objects/SetOfQuiz.dart';
import '../../object/categories.dart';
import 'achievement_details_widget.dart';
import 'big_text_in_achievement.dart';
import 'number_of_quiz.dart';

class AchievementBloc extends StatelessWidget {
  String imgCrownPath;
  String numberOfQuizz;
  String imgTroyphyPath;
  int yourHighestScores;
  int maxScoresOfQuizz;
  AchievementBloc(
      {Key? key,
      required this.imgCrownPath,
      required this.numberOfQuizz,
      required this.imgTroyphyPath,
      required this.yourHighestScores,
      required this.maxScoresOfQuizz,
      required this.dataBoxCategories,
      required this.setOfQuiz})
      : super(key: key);

  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                              ImgInAchievementBoxDecor(imgCrownPath)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 4.0),
                    child: Row(
                      children: [
                        NumberOfQuiz(
                          dataBoxCategories: dataBoxCategories,
                          setOfQuiz: setOfQuiz,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                              ImgInAchievementBoxDecor(imgTroyphyPath)),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                    child: Row(
                      children: [
                        BigTextInAchievement(
                            frontText: yourHighestScores.toString(),
                            behindText: '/$maxScoresOfQuizz'),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
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
