import 'package:flutter/material.dart';
import '../component/backgound.dart';
import '../component/custom_box_categories.dart';
import '../component/custom_box_quiz.dart';
import '../component/topbarjobs.dart';
import '../object/categories.dart';
import '../screen/list_quiz.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class QuizOverview extends StatelessWidget {
  QuizOverview({Key? key}) : super(key: key);
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

  final List<Categories> categories = [
    Categories("IT", "Programming"),
    Categories("IT", "Data Analytics"),
    Categories("IT", "Data Analytics 1  "),
    Categories("IT", "Data Analytics 2"),
    Categories("IT", "Data Analytics 3"),
    Categories("IT", "Data Analytics 4"),
  ];

  Widget _buildListItemQuiz(BuildContext context, int index) {
    //horizontal
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: CustomBoxQuiz(
              height: 165,
              width: 135,
              color: listColor[index % listColor.length],
              quizName: recently_quiz_name[index],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context, int index) {
    double customHeight = 165;
    if ((index - 1) == 0) customHeight = 185;

    return Container(
      height: customHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            child: Container(
              child: CustomBoxCategories(
                height: 165,
                width: 135,
                color: listColor[(index) % listColor.length],
                categories: categories[index],
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ListQuiz(
                    listquiz: recently_quiz_name,
                    color: listColor[(index) % listColor.length],
                    categories: categories[index]))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Color> color = [
      Color.fromRGBO(39, 25, 98, 0),
      Color.fromRGBO(50, 37, 107, 0),
      Color.fromRGBO(39, 25, 98, 1),
      Color.fromRGBO(50, 37, 107, 1),
    ];
    return Stack(
      children: [
        background(color: color),
        Column(children: [
          Container(
            margin: EdgeInsets.only(top: 50, left: 20),
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Recently Quiz",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RobotoSlab"),
              ),
            ),
          ),
          SizedBox(
            height: 220,
            child: Expanded(
              child: ScrollSnapList(
                  onItemFocus: (index) {},
                  itemSize: 135,
                  itemBuilder: _buildListItemQuiz,
                  itemCount: recently_quiz_name.length,
                  reverse: true,
                  dynamicItemSize: true,
                  dynamicItemOpacity: 0.9),
            ),
          ),

          // Ghep vo,
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 5),
            padding: EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Categories",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "RobotoSlab"),
              ),
            ),
          ),
          TopBar(),
          Container(
            height: MediaQuery.of(context).size.height - 362,
            child: Stack(children: [
              Container(
                  child: MasonryGridView.count(
                itemCount: categories.length,
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 0,
                itemBuilder: (context, index) =>
                    _buildCategories(context, index),
              )),
              Column(children: [
                Container(
                  height: (MediaQuery.of(context).size.height - 362) * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(15, 20, 60, 1),
                    Color.fromRGBO(15, 20, 60, 0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Spacer(),
                Container(
                  height: (MediaQuery.of(context).size.height - 362) * 0.1,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(15, 20, 60, 0),
                    Color.fromRGBO(15, 20, 60, 1)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
              ]),
            ]),
          )
        ]),
      ],
    );
  }
}
