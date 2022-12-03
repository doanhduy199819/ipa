import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/components/up_vote_stream_builder.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/company_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';

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
    const defaultVoteBloc = VoteBloc(
      numberOfAnswers: 0,
      numberOfVotes: 0,
    );

    return Row(
      crossAxisAlignment: isShowingDetail
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, left: 4.0, right: 8.0),
          child: UpVoteStreamBuilder(
            question: question,
            defaultVoteBloc: defaultVoteBloc,
            child: ((voteNum, numberOfAnswers) => VoteBloc(
                  numberOfVotes: voteNum,
                  numberOfAnswers: numberOfAnswers,
                )),
          ),
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
