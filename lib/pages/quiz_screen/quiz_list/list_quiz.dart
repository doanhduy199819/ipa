import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz_list/component/list_box_quiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz_overview/component/list_box_categories.dart';
import '../component/backgound.dart';
import '../object/categories.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../component/custom_box_quiz.dart';

class ListQuiz extends StatelessWidget {
  ListQuiz(
      {Key? key,
      required this.listquiz,
      required this.color,
      required this.categories})
      : super(key: key);

  final List<String> listquiz;
  final List<Color> color;
  final DataBoxCategories categories;

  final List<List<Color>> listColor = [
    [
      Color.fromRGBO(43, 35, 139, 1),
      Color.fromRGBO(153, 0, 255, 1),
      Color.fromRGBO(145, 171, 217, 1),
      Color.fromRGBO(213, 227, 236, 1)
    ],
    [
      Color.fromRGBO(255, 189, 89, 1),
      Color.fromRGBO(255, 102, 196, 1),
      Color.fromRGBO(255, 180, 96, 1),
      Color.fromRGBO(254, 236, 164, 1)
    ],
    [
      Color.fromRGBO(192, 162, 204, 1),
      Color.fromRGBO(255, 110, 192, 1),
      Color.fromRGBO(237, 201, 175, 1),
      Color.fromRGBO(250, 239, 255, 1)
    ],
    [
      Color.fromRGBO(194, 239, 170, 1),
      Color.fromRGBO(43, 35, 139, 1),
      Color.fromRGBO(164, 195, 121, 1),
      Color.fromRGBO(247, 253, 244, 1)
    ],
  ];

  Widget CustomBoxHeader(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(left: size.width * 0.1, bottom: 20),
        padding: EdgeInsets.all(size.width * 0.05),
        height: size.height / 5,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            color: color[2],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: color[3].withOpacity(0.3),
                blurRadius: 15.0,
                spreadRadius: 5.0,
              )
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Spacer(),
          Text(categories.name.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: color[3],
                fontSize: 20,
                fontWeight: FontWeight.w100,
              )),
          Text(categories.specialized.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: color[3],
                  fontSize: 26,
                  fontFamily: "RobotoSlab")),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Stack(children: [
      background(
        color: color,
        havenavigationbar: 0,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: size.height * 0.1,
          width: 50,
          padding: EdgeInsets.only(top: 20),
          child: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: color[2],
            ),
            onTap: () {
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          ),
        ),
        CustomBoxHeader(context),
        Container(
            height: size.height * 0.7 - 20,
            child: Stack(children: [
              Container(
                  child: ListBoxQuiz(
                dataBoxCategories: categories,
              )),
              Column(children: [
                Container(
                  height: (size.height * 0.7 - 20) * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(15, 20, 60, 1),
                    Color.fromRGBO(15, 20, 60, 0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Spacer(),
                Container(
                  height: (size.height * 0.7 - 20) * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(15, 20, 60, 0),
                    Color.fromRGBO(15, 20, 60, 1)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
              ]),
            ])),
      ]),
    ]));
  }
}
