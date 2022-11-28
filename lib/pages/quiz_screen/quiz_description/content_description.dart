import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/SetOfQuiz.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/object/categories.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class ContentDescriptionWidget extends StatelessWidget {
  ContentDescriptionWidget(
      {Key? key,
      required this.widthOfDevice,
      required this.dataBoxCategories,
      required this.setOfQuiz})
      : super(key: key);
  double widthOfDevice;
  // List<String> contentDescription;
  final DataBoxCategories dataBoxCategories;
  final SetOfQuiz setOfQuiz;

  Container ItemBuild(List<String> contentDescription) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 241, 255, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      width: widthOfDevice - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...(contentDescription.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "- " + e,
                style: const TextStyle(
                    //fontFamily: 'Nunito',
                    ),
              ),
            );
          }).toList()),
        ],
      ),
    );
  }

  Future<List<String>?> LoadData() async {
    List<String>? result;
    result = await DatabaseService().getDesciptionQuiz(
        dataBoxCategories.jobid, dataBoxCategories.categoriesid, setOfQuiz.id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LoadData(),
      builder: (context, AsyncSnapshot<List<String>?> snapshot) {
        return Helper.handleSnapshot(snapshot) ?? ItemBuild(snapshot.data!);
      },
    );
  }
}
