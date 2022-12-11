import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/interactive_bloc.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';


import '../../../objects/Helper.dart';
import '../../../services/database_service.dart';

class InteractiveStreamBuilder extends StatelessWidget {
  final ExperiencePost experiencePost;
  final InteractiveBloc defaultInteractiveBloc;
  final Widget Function(int voteNum, int numberOfAnswers) child;
  InteractiveStreamBuilder(
      {Key? key,
        required this.experiencePost,
        required this.defaultInteractiveBloc,
        required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: DatabaseService().getLikeNumExperiencePost(experiencePost.post_id ?? '0'),
        builder: (context, voteNumSnapshot) {
          return Helper.handleSnapshot(
              voteNumSnapshot, defaultInteractiveBloc) ??
              StreamBuilder<int>(
                  stream: DatabaseService()
                      .getNumberOfComment(experiencePost.post_id ?? '0'),
                  builder: (context, numberOfAnswersSnapshot) {
                    return Helper.handleSnapshot(
                        numberOfAnswersSnapshot, defaultInteractiveBloc) ??
                        child(voteNumSnapshot.data ?? 0,
                            numberOfAnswersSnapshot.data ?? 0);
                  });
        });
  }
}
