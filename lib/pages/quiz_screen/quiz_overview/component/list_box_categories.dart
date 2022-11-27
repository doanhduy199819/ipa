import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../objects/Categories.dart';
import '../../../../objects/Job.dart';
import '../../../../services/database_service.dart';
import '../../object/categories.dart';
import '../../quiz_list/list_quiz.dart';
import 'custom_box_categories.dart';

class ListBoxCategories extends StatelessWidget {
  ListBoxCategories({Key? key}) : super(key: key);
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

  final List<DataBoxCategories> templatecategories = [
    DataBoxCategories(specialized: "IT", name: "Programming"),
    DataBoxCategories(specialized: "IT", name: "Data Analytics"),
    DataBoxCategories(specialized: "IT", name: "Data Analytics1"),
    DataBoxCategories(specialized: "IT", name: "Data Analytics2"),
    DataBoxCategories(specialized: "IT", name: "Data Analytics3"),
  ];

  Widget _buildCategories(
      BuildContext context, int index, DataBoxCategories categories) {
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
                categories: categories,
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ListQuiz(
                    listquiz: recently_quiz_name,
                    color: listColor[(index) % listColor.length],
                    categories: categories))),
          )
        ],
      ),
    );
  }

  Future<List<DataBoxCategories>?> loadData() async {
    List<Job>? listJob = [];
    List<DataBoxCategories> result = [];
    listJob = await DatabaseService().getJobList();
    for (int i = 0; i < listJob!.length; i++) {
      List<Categories>? listCategories = [];
      listCategories =
          await DatabaseService().getCategoriesList(listJob[i].id!);
      listJob[i].categories = listCategories;
      listJob[i].categories?.forEach((categories) {
        result.add(DataBoxCategories(
            jobid: listJob?[i].id,
            specialized: listJob?[i].name,
            categoriesid: categories.id,
            name: categories.name));
      });
    }
    ;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<DataBoxCategories>?> snapshot) {
          return Helper().handleSnapshot(snapshot) ??
              MasonryGridView.count(
                itemCount: snapshot.data!.length,
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 0,
                itemBuilder: (context, index) =>
                    _buildCategories(context, index, snapshot.data![index]),
              );
        });
  }
}
