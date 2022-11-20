import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/question_content.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';

import '../../../../values/Home_Screen_Assets.dart';
import '../qa_detail_screen.dart';
import 'company_bloc.dart';

class ListViewQAWidget extends StatelessWidget {
  final List<Question>? questions;
  // String? urlImageCompany;
  const ListViewQAWidget({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.custom(
        childrenDelegate:
            SliverChildBuilderDelegate(childCount: questions?.length ?? 0,
                (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => const QaDetailScreen(),
                  settings: RouteSettings(
                    arguments: questions?[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              child: buildQuestionContent(question: questions![index]),
            ),
          );
        }),
      ),
    );
  }

  // Handle when item have image company or haven't
}
