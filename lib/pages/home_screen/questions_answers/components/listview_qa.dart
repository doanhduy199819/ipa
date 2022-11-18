import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';

import '../../../../values/Home_Screen_Assets.dart';
import '../qa_detail_screen.dart';
import 'company_bloc.dart';

class ListViewQAWidget extends StatelessWidget {
  List<Question>? questions;
  // String? urlImageCompany;
  ListViewQAWidget({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
            childCount: questions!.length, (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => QaDetailScreen(),
                  settings: RouteSettings(
                    arguments: questions![index],
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
              child: _buildItemListView(index),
            ),
          );
        }),
      ),
    );
  }

  // Handle when item have image company or haven't
  Row _buildItemListView(int index) {
    // return (questions?[index].company_id == null)
    return (false)
        ? Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
                child: VoteBloc(
                    numberOfVotes: questions?[index].voteNum ?? 0,
                    numberOfAnswers: questions?[index].numberOfAnswers ?? 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TitleTagContentQABloc(
                    title: questions?[index].title,
                    category: questions?[index].categories,
                    content: questions?[index].content,
                    urlImageCompany: HomeScreenAssets.lgLogo),
              ),
            ],
          )
        : Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
                child: VoteBloc(
                    numberOfVotes: questions?[index].voteNum ?? 0,
                    numberOfAnswers: questions?[index].numberOfAnswers ?? 0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TitleTagContentQABloc(
                  title: questions?[index].title,
                  category: questions?[index].categories,
                  content: questions?[index].content,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CompanyBloc(urlImage: questions?[index].company_id),
              ),
              // const Spacer(),
              // ]
            ],
          );
  }
}
