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
      this.downVoteHandle,
      this.isHorizontal = true})
      : super(key: key);

  final int? defaultVoteState;
  final int? voteNum;
  final double iconSize;
  final bool isHorizontal;

  // Expose methods
  final void Function(bool)? upVoteHandle;
  final void Function(bool)? downVoteHandle;

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
    debugPrint('build updown box');
    if (widget.isHorizontal) {
      return Row(children: _getChildren());
    } else {
      return Row(
        children: [
          Column(children: _getChildren()),
        ],
      );
    }
  }

  List<Widget> _getChildren() {
    return [
      InterractionIcon(
        activeIcon: Icon(
          Icons.arrow_upward_rounded,
          size: widget.iconSize,
          color: Colors.white,
        ),
        activeBackgroundColor: Colors.green,
        unActiveIcon: Icon(
          Icons.arrow_upward_rounded,
          size: widget.iconSize,
          color: Colors.grey,
        ),
        unActiveBackgroundColor: Colors.white,
        isActive: voteState == 1,
        onActiveChange: (isActive) {
          _upVoteHandle(isActive);
          if (widget.upVoteHandle != null) widget.upVoteHandle!(isActive);
        },
      ),
      const SizedBox(width: 12.0, height: 12.0),
      if (widget.voteNum != null) ...[
        Text(widget.voteNum.toString()),
        const SizedBox(width: 12.0),
      ],
      InterractionIcon(
        activeIcon: Icon(
          Icons.arrow_downward_rounded,
          size: widget.iconSize,
          color: Colors.white,
        ),
        activeBackgroundColor: Colors.red,
        unActiveIcon: Icon(
          Icons.arrow_downward_rounded,
          size: widget.iconSize,
          color: Colors.grey,
        ),
        unActiveBackgroundColor: Colors.white,
        isActive: voteState == -1,
        onActiveChange: (isActive) {
          _downVoteHandle(isActive);
          if (widget.downVoteHandle != null) widget.downVoteHandle!(isActive);
        },
      ),
    ];
  }

  void _upVoteHandle(bool isUpvoteActive) {
    // TODO: Add userId to upvote_users field of this comment
    setState(() {
      voteState = (isUpvoteActive) ? 0 : 1;
    });
  }

  void _downVoteHandle(bool isUpvoteActive) {
    // TODO: Add userId to downvote_users field of this comment
    setState(() {
      voteState = (isUpvoteActive) ? 0 : -1;
    });
  }
}
