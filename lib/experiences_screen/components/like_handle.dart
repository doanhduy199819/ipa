import 'package:flutter/material.dart';

import 'like_icon.dart';

class LikePost extends StatefulWidget {
  const LikePost(
      {Key? key,
        this.defaultVoteState,
        this.likeNum,
        this.likeHandle,
        this.isHorizontal = true})
      : super(key: key);

  final int? defaultVoteState;
  final int? likeNum;
  final bool isHorizontal;

  // Expose methods
  final void Function(bool)? likeHandle;


  @override
  State<LikePost> createState() => _LikePostState();
}

class _LikePostState extends State<LikePost> {
  late int likeState;

  @override
  void initState() {
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
          _likeHandle(isActive,);
          if (widget.likeHandle != null) widget.likeHandle!(isActive);
        },
      ),
      // const SizedBox(width: 12.0, height: 12.0),
      // if (widget.voteNum != null) ...[
      //   Text(widget.voteNum.toString()),
      //   const SizedBox(width: 12.0),
      // ],
    ];
  }

  void _likeHandle(bool isLikeActive) {
    // TODO: Add userId to upvote_users field of this comment
    setState(() {
      likeState = (isLikeActive) ? 0 : 1;
    });
  }

}
