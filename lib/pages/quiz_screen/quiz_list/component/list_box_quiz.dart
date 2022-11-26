import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz/quiz.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../objects/SetOfQuiz.dart';
import '../../component/custom_box_quiz.dart';

class ListBoxQuiz extends StatelessWidget {
  ListBoxQuiz({Key? key, required this.dataBoxCategories}) : super(key: key);
  final DataBoxCategories dataBoxCategories;
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

  Widget _buildItemQuiz(
      BuildContext context, int index, List<SetOfQuiz> setOfQuiz) {
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
              setOfQuiz: setOfQuiz[index],
              dataBoxCategories: dataBoxCategories,
            ),
          )
        ],
      ),
    );
  }

  Future<List<SetOfQuiz>?> loadData() async {
    List<SetOfQuiz>? result = [];
    result = await DatabaseService().getSetOfQuizList(
        dataBoxCategories.jobid, dataBoxCategories.categoriesid);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<SetOfQuiz>?> snapshot) {
        return Helper().handleSnapshot(snapshot) ??
            MasonryGridView.count(
              itemCount: snapshot.data!.length,
              crossAxisCount: 2,
              mainAxisSpacing: 30,
              crossAxisSpacing: 0,
              itemBuilder: (context, index) {
                return _buildItemQuiz(context, index, snapshot.data!);
              },
            );
      },
    );
  }
}
