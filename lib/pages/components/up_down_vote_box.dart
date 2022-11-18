import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class UpDownVoteBox extends StatefulWidget {
  const UpDownVoteBox({Key? key, required this.comment}) : super(key: key);

  final Comment comment;

  @override
  State<UpDownVoteBox> createState() => _UpDownVoteBoxState();
}

class _UpDownVoteBoxState extends State<UpDownVoteBox> {
  int voteState = 0;
  late int voteNum;

  @override
  void initState() {
    // TODO: implement initState
    voteNum = widget.comment.vote;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InterractionIcon(
          activeIcon: Icon(
            Icons.arrow_upward_rounded,
            size: 12.0,
            color: Colors.white,
          ),
          unActiveIcon: Icon(
            Icons.arrow_upward_rounded,
            size: 12.0,
            color: Colors.grey,
          ),
          onTap: _upVoteTap,
          isActive: voteState == 1,
        ),
        const SizedBox(width: 12.0),
        Text(voteNum.toString()),
        const SizedBox(width: 12.0),
        InterractionIcon(
          activeIcon: Icon(
            Icons.arrow_upward_rounded,
            size: 12.0,
            color: Colors.white,
          ),
          unActiveIcon: Icon(
            Icons.arrow_upward_rounded,
            size: 12.0,
            color: Colors.grey,
          ),
          onTap: _downVoteTap,
          isActive: voteState == -1,
        ),
      ],
    );
  }

  void _upVoteTap() {
    // TODO: Add userId to upvote_users field of this comment
    DatabaseService().upVote(widget.comment);
  }

  void _downVoteTap() {
    // TODO: Add userId to downvote_users field of this comment
  }
}
