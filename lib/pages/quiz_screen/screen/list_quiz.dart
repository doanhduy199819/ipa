import 'package:flutter/material.dart';
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
  final Categories categories;

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

  final List<String> recently_quiz_name = [
    "HTML",
    "CSS",
    "JavaScript",
    "MySQL",
    "Python",
    "PHP"
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
          Text(categories.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: color[3],
                fontSize: 20,
                fontWeight: FontWeight.w100,
              )),
          Text(categories.specialized,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: color[3],
                  fontSize: 26,
                  fontFamily: "RobotoSlab")),
        ]));
  }

  Widget _buildItemQuiz(BuildContext context, int index) {
    double customHeight = 165;
    if ((index - 1) == 0) customHeight = 185;

    return Container(
      width: 145,
      height: customHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 165,
            width: 135,
            child: CustomBoxQuiz(
              height: 165,
              width: 135,
              color: listColor[(index) % listColor.length],
              quizName: recently_quiz_name[index],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Stack(children: [
      background(color: color),
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
              Navigator.pop(context);
            },
          ),
        ),
        CustomBoxHeader(context),
        Container(
            height: size.height * 0.7 - 20,
            child: Stack(children: [
              Container(
                child: MasonryGridView.count(
                  itemCount: recently_quiz_name.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 0,
                  itemBuilder: (context, index) {
                    return _buildItemQuiz(context, index);
                  },
                ),
              ),
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
