import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class UpDownVoteBox extends StatefulWidget {
  const UpDownVoteBox(
      {Key? key,
      this.defaultVoteState,
      this.voteNum,
      this.iconSize = 12.0,
      this.upVoteHandle,
      this.downVoteHandle})
      : super(key: key);

  final int? defaultVoteState;
  final int? voteNum;
  final double iconSize;

  // Expose methods
  final Function(bool)? upVoteHandle;
  final Function(bool)? downVoteHandle;

  @override
  State<UpDownVoteBox> createState() => _UpDownVoteBoxState();
}

class _UpDownVoteBoxState extends State<UpDownVoteBox> {
  late int voteState;

  @override
  void initState() {
    // TODO: implement initState
    voteState = widget.defaultVoteState ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InterractionIcon(
          activeIcon: Icon(
            Icons.arrow_upward_rounded,
            size: widget.iconSize,
            color: Colors.white,
          ),
          unActiveIcon: Icon(
            Icons.arrow_upward_rounded,
            size: widget.iconSize,
            color: Colors.grey,
          ),
          isActive: voteState == 1,
        ),
        const SizedBox(width: 12.0),
        if (widget.voteNum != null) ...[
          Text(widget.voteNum.toString()),
          const SizedBox(width: 12.0),
        ],
        InterractionIcon(
          activeIcon: Icon(
            Icons.arrow_upward_rounded,
            size: widget.iconSize,
            color: Colors.white,
          ),
          unActiveIcon: Icon(
            Icons.arrow_upward_rounded,
            size: widget.iconSize,
            color: Colors.grey,
          ),
          isActive: voteState == -1,
        ),
      ],
    );
  }

  void _upVoteHandle(bool isUpvoteActive) {
    // TODO: Add userId to upvote_users field of this comment
    setState(() {
      voteState == 1 ? 0 : 1;
    });
  }

  void _downVoteHandle() {
    // TODO: Add userId to downvote_users field of this comment
    voteState == -1 ? 0 : -1;
  }
}
