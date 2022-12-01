import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import '../component/custom_box.dart';
import '../controller/question_controller.dart';
import '../quiz_description/quiz_description.dart';

class CustomBoxQuiz extends StatelessWidget {
  CustomBoxQuiz(
      {Key? key,
      required this.height,
      required this.width,
      required this.color,
      required this.setOfQuiz,
      required this.dataBoxCategories})
      : super(key: key);

  final double height;
  final double width;
  final List<Color> color;
  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;

  Widget CustomButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: height * 0.75, left: width * 0.15),
        height: height * 0.14,
        width: width * 0.7,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(255, 255, 255, 0.1),
                blurRadius: 5.0,
                spreadRadius: 5.0,
              )
            ]),
        child: RadiantGradientMask(
          child: Icon(
            size: width * 0.13,
            Icons.play_arrow,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ),
      onTap: (() {
        QuesionController.dataBoxCategories = dataBoxCategories;
        QuesionController.setOfQuiz = setOfQuiz;
        QuesionController().reset();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => QuizDescription(
                    dataBoxCategories: dataBoxCategories,
                    setOfQuiz: setOfQuiz,
                  )),
        );
      }),
    );
  }

  Widget RadiantGradientMask({required child}) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.topCenter,
        radius: 0.4,
        colors: [color[1].withOpacity(0.5), color[0].withOpacity(0.5)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            CustomBox(height: height, width: width, color: color),
            CustomButton(context),
            Container(
              height: 165 * 0.7,
              margin: EdgeInsets.only(
                  left: 16.5, right: 16.5, top: 10, bottom: 165 * 0.3),
              child: Column(
                children: [
                  Spacer(),
                  Container(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(setOfQuiz.name.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontFamily: "RobotoSlab",
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                  Container(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("Quiz",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 26,
                            fontFamily: "RobotoSlab")),
                  ))
                ],
              ),
            )
          ],
        ));
  }
}
