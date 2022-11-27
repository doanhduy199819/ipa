import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/company_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class buildQuestionContent extends StatelessWidget {
  const buildQuestionContent({
    Key? key,
    required this.question,
    // required this.index,
    this.isShowingDetail = false,
  }) : super(key: key);

  final Question question;
  // final int index;
  final bool isShowingDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: isShowingDetail
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 4.0, right: 8.0),
          child: StreamBuilder<int>(
              stream: DatabaseService().getVoteNum(question.id ?? '0'),
              builder: (context, voteNumSnapshot) {
                return Helper().handleSnapshot(voteNumSnapshot) ??
                    StreamBuilder<int>(
                        stream: DatabaseService()
                            .getNumberOfAnswers(question.id ?? '0'),
                        builder: (context, numberOfAnswersSnapshot) {
                          return Helper()
                                  .handleSnapshot(numberOfAnswersSnapshot) ??
                              VoteBloc(
                                  numberOfVotes: voteNumSnapshot.data ?? 0,
                                  numberOfAnswers:
                                      numberOfAnswersSnapshot.data ?? 0);
                        });
              }),
          // child: VoteBloc(
          //   numberOfAnswers: question.numberOfAnswers,
          //   numberOfVotes: question.voteNum,
          // ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TitleTagContentQABloc(
              title: question.title,
              category: question.categories,
              content: question.content,
              isShowingDetails: isShowingDetail,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(right: 4.0),
          child: CompanyBloc(urlImage: question.company_id),
        ),
      ],
    );
  }
}
