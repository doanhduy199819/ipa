import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../quiz/component/backgound_quiz.dart';
import '../quiz/component/custom_bottom_bar.dart';
import '../quiz/component/custom_box_question_quiz.dart';
import '../quiz/component/table_of_content.dart';
import '../controller/question_controller.dart';
import '../quiz/object/color_quiz_theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Color bodyColor = ColorQuizTheme().list[ColorQuizTheme.index].bodyColor;
  Color circleHeaderColor =
      ColorQuizTheme().list[ColorQuizTheme.index].circleHeaderColor;
  Color textQuestionColor =
      ColorQuizTheme().list[ColorQuizTheme.index].textQuestionColor;
  Color backgroundQuestionColor =
      ColorQuizTheme().list[ColorQuizTheme.index].backgroundQuestionColor;

  bool statusTheme = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    QuesionController().addDataTemplate();
    super.initState();
  }

  Container CustomAppBar() {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 20),
      height: 30,
      child: Row(children: [
        InkWell(
            child: Icon(Icons.arrow_back_ios_rounded,
                color: Color.fromRGBO(199, 200, 238, 1)),
            onTap: () {
              Navigator.pop(context);
            }),
        Spacer(),
        FlutterSwitch(
          width: 60.0,
          height: 30.0,
          borderRadius: 30.0,
          padding: 2.0,
          value: statusTheme,
          activeToggleColor: Color(0xFF6E40C9),
          inactiveToggleColor: Color(0xFF2F363D),
          activeColor: Color(0xFF271052),
          inactiveColor: Colors.white,
          activeIcon: Icon(
            Icons.nightlight_round,
            color: Color(0xFFF8E3A1),
          ),
          inactiveIcon: Icon(
            Icons.wb_sunny,
            color: Color(0xFFFFDF5D),
          ),
          onToggle: (val) {
            setState(() {
              statusTheme = val;
              ColorQuizTheme().changeColorQuizTheme();
              changeColorTheme(ColorQuizTheme().list[ColorQuizTheme.index]);
            });
          },
        ),
        InkWell(
          onTap: () {
            _key.currentState!.openEndDrawer();
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.grid_view_rounded,
                color: Color.fromRGBO(199, 200, 238, 1)),
          ),
        ),
      ]),
    );
  }

  void changeColorTheme(CustomeColorQuiz themeColor) {
    bodyColor = themeColor.bodyColor;
    circleHeaderColor = themeColor.circleHeaderColor;
    textQuestionColor = themeColor.textQuestionColor;
    backgroundQuestionColor = themeColor.backgroundQuestionColor;
  }

  Row CustomBottomBar(BuildContext context) {
    InkWell firstButton = InkWell(
        child: BottomBar().firstButton(circleHeaderColor, textQuestionColor),
        onTap: () {
          setState(() {
            BottomBar().onTagFirstButton();
          });
        });
    InkWell secondButton = InkWell(
        child: BottomBar().secondButton(MediaQuery.of(context).size.width - 100,
            circleHeaderColor, textQuestionColor),
        onTap: () {
          setState(() {
            BottomBar().onTagSecondButton(context);
          });
        });
    return Row(
      children: [firstButton, secondButton],
    );
  }

  Drawer endDrawer() {
    Drawer d = Drawer(
      width: 200,
      backgroundColor: backgroundQuestionColor,
      child: Container(
        padding: EdgeInsets.all(10),
        child: MasonryGridView.count(
          itemCount: QuesionController.numberQuestion,
          crossAxisCount: 3,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          itemBuilder: (context, index) {
            return InkWell(
                child: AllQuestionDrawer(index: index),
                onTap: () {
                  setState(() {
                    QuesionController.index = index;
                  });
                });
          },
        ),
      ),
    );
    return d;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        endDrawer: endDrawer(),
        body: Stack(children: [
          BackgroundQuiz(
            body: bodyColor,
            circleHeader: circleHeaderColor,
          ),
          Column(children: [
            CustomAppBar(),
            CustomQuestionQuiz(),
            CustomBottomBar(context)
          ])
        ]));
  }
}
