import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import 'like_icon.dart';
class LikeComment extends StatefulWidget {
  const LikeComment(
      {Key? key,
        required this.experiencePostId,
        this.defaultVoteState,
        this.likeNum,
        required this.likeHandle,
        this.isHorizontal = true,
        this.commentId})
      : super(key: key);
  final String? experiencePostId;
  final int? defaultVoteState;
  final int? likeNum;
  final bool isHorizontal;
  final String? commentId;

  // Expose methods
  final void Function(bool,String)? likeHandle;


  @override
  State<LikeComment> createState() => _LikeCommentState();
}

class _LikeCommentState extends State<LikeComment> {
  late int likeState;

  @override
  void initState()   {
    // TODO: implement initState
    likeState = widget.defaultVoteState ?? 0;

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
      LikeIcon(
        activeIcon: Icon(
          Icons.favorite,
          color: const Color.fromARGB(255, 224, 51, 51).withOpacity(0.5),
          size: 22,
        ),
        unActiveIcon: Icon(
          Icons.favorite,
          color: Colors.grey.withOpacity(0.5),
          size: 22,
        ),
        isActive: likeState == 1,
        onActiveChange: (isActive) {
          _likeCommentHandle(isActive,widget.commentId);
          if (widget.likeHandle != null) widget.likeHandle!(isActive,widget.commentId ?? '0');
        },
      ),
      // const SizedBox(width: 12.0, height: 12.0),
      // if (widget.voteNum != null) ...[
      //   Text(widget.voteNum.toString()),
      //   const SizedBox(width: 12.0),
      // ],
    ];
  }

  void _likeCommentHandle(bool isLikeActive,String? idComment) {
    // TODO: Add userId to upvote_users field of this comment
    setState(() {
      likeState = (isLikeActive) ? 0 : 1;
    });
  }

}