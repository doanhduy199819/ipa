import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class UpVoteStreamBuilder extends StatelessWidget {
  const UpVoteStreamBuilder({
    Key? key,
    required this.question,
    required this.defaultVoteBloc,
    required this.child,
  }) : super(key: key);

  final Question question;
  final VoteBloc defaultVoteBloc;
  final Widget Function(int voteNum, int numberOfAnswers) child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: DatabaseService().getVoteNum(question.id ?? '0'),
        builder: (context, voteNumSnapshot) {
          return Helper.handleSnapshot(voteNumSnapshot, defaultVoteBloc) ??
              StreamBuilder<int>(
                  stream:
                      DatabaseService().getNumberOfAnswers(question.id ?? '0'),
                  builder: (context, numberOfAnswersSnapshot) {
                    return Helper.handleSnapshot(
                            numberOfAnswersSnapshot, defaultVoteBloc) ??
                        child(voteNumSnapshot.data ?? 0,
                            numberOfAnswersSnapshot.data ?? 0);
                  });
        });
  }
}
