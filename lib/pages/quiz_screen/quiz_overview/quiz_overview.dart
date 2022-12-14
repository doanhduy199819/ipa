import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/job_controller.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz_overview/component/list_box_categories.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/services/quiz_service.dart';
import '../../../objects/Categories.dart';
import '../../../objects/Job.dart';
import '../../../objects/RecentlyQuiz.dart';
import '../component/backgound.dart';
import 'component/custom_box_categories.dart';
import '../component/custom_box_quiz.dart';
import 'component/topbarjobs.dart';
import '../quiz_list/list_quiz.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'component/topbarjobs.dart';

class QuizOverview extends StatelessWidget {
  QuizOverview({
    Key? key,
  }) : super(key: key);
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

  Widget buildListItemQuiz(BuildContext context, int index, RecentlyQuiz data) {
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
              setOfQuiz: SetOfQuiz(id: data.quizId, name: data.quizName),
              dataBoxCategories: DataBoxCategories(
                  jobid: data.jobId, categoriesid: data.categoriesId),
            ),
          )
        ],
      ),
    );
  }

  Future<List<RecentlyQuiz>> loadData() async {
    return await DatabaseService().getRecentlyQuiz();
  }

  @override
  Widget build(BuildContext context) {
    List<Color> color = [
      Color.fromRGBO(39, 25, 98, 0),
      Color.fromRGBO(50, 37, 107, 0),
      Color.fromRGBO(39, 25, 98, 1),
      Color.fromRGBO(50, 37, 107, 1),
    ];

    return FutureBuilder(
        future: loadData(),
        builder: (context, AsyncSnapshot<List<RecentlyQuiz>> snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error.toString()}");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return buildItem(snapshot, color, context);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Stack buildItem(AsyncSnapshot<List<RecentlyQuiz>> snapshot, List<Color> color,
      BuildContext context) {
    return Stack(
      children: [
        snapshot.data?.length != 0
            ? background(
                color: color,
                havenavigationbar: 1,
              )
            : Container(
                color: Color.fromRGBO(15, 20, 60, 1),
              ),
        Column(children: [
          snapshot.data?.length != 0
              ? Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
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
                )
              : Container(),
          snapshot.data?.length != 0
              ? SizedBox(
                  height: 206,
                  child: Expanded(
                    child: ScrollSnapList(
                        onItemFocus: (index) {},
                        itemSize: 135,
                        itemBuilder: (context, index) {
                          return buildListItemQuiz(
                              context, index, snapshot.data![index]);
                        },
                        itemCount: snapshot.data!.length < 7
                            ? snapshot.data!.length
                            : 7,
                        reverse: true,
                        dynamicItemSize: true,
                        dynamicItemOpacity: 0.9),
                  ),
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 5, top: 10),
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
            margin: EdgeInsets.only(top: 4),
            height: MediaQuery.of(context).size.height -
                138 -
                235 * (snapshot.data?.length != 0 ? 1 : 0),
            child: Stack(children: [
              Container(
                child: ListBoxCategories(),
              ),
              Column(children: [
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(15, 20, 60, 1),
                    Color.fromRGBO(15, 20, 60, 0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                ),
                Spacer(),
                Container(
                  height: 20,
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
