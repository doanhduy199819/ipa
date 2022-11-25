// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';

class CommentBoxWidget extends StatefulWidget {
  const CommentBoxWidget(
      {Key? key,
      this.photoUrl,
      this.userName,
      required this.isShowingUpvote,
      this.content,
      this.fontSize = 12,
      this.postFix})
      : super(key: key);

  final String? photoUrl;
  final String? userName;
  final String? content;
  final bool isShowingUpvote;
  final int? fontSize;
  final Widget? postFix;

  @override
  State<CommentBoxWidget> createState() => _CommentBoxWidgetState();
}

class _CommentBoxWidgetState extends State<CommentBoxWidget> {
  int upVoteNum = 10;
  late int voteStat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voteStat = 0;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild comment box ${voteStat}');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoBox(
            photoUrl: widget.photoUrl,
            userName: widget.userName,
            postFix: widget.postFix,
          ),
          _buildCommentContent(
            commentContent: widget.content,
          ),
          // const SizedBox(height: 8.0),
          _buildInteractions(
            voteNum: updateVoteNum,
            voteState: voteStat,
            isShowingUpvote: widget.isShowingUpvote,
            upVoteTap: () => setState(() {
              voteStat = (voteStat == 1) ? 0 : 1;
            }),
            downVoteTap: () => setState(() {
              voteStat = (voteStat == -1) ? 0 : -1;
            }),
          ),
          Divider(),
        ],
      ),
    );
  }

  int get updateVoteNum {
    return upVoteNum + voteStat;
  }
}

class _buildInteractions extends StatelessWidget {
  _buildInteractions({
    Key? key,
    required this.voteNum,
    this.upVoteTap,
    this.downVoteTap,
    required this.voteState,
    required this.isShowingUpvote,
  }) : super(key: key);

  final int voteNum;
  final void Function()? upVoteTap;
  final void Function()? downVoteTap;
  final int voteState;
  final bool isShowingUpvote;

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuild interactions');
    debugPrint('vote state $voteState');

    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        if (isShowingUpvote) ...[
          InterractionIcon(
            onTap: upVoteTap,
            isActive: (voteState == 1),
            activeIcon: Icon(
              Icons.arrow_upward_rounded,
              size: 12.0,
              color: Colors.white,
            ),
            activeBackgroundColor: Colors.green,
            unActiveIcon: Icon(
              Icons.arrow_upward_rounded,
              size: 12.0,
              color: Colors.grey,
            ),
            unActiveBackgroundColor: Colors.white,
          ),
          const SizedBox(width: 12.0),
          Text(voteNum.toString()),
          const SizedBox(width: 12.0),
          InterractionIcon(
            activeIcon: Icon(
              Icons.arrow_downward_rounded,
              size: 12.0,
              color: Colors.white,
            ),
            activeBackgroundColor: Colors.red,
            unActiveIcon: Icon(
              Icons.arrow_downward_rounded,
              size: 12.0,
              color: Colors.grey,
            ),
            unActiveBackgroundColor: Colors.white,
            onTap: downVoteTap,
            isActive: (voteState == -1),
          ),
          const SizedBox(width: 12.0),
        ],
        _buildReplyButton(),
        const SizedBox(width: 16.0),
        Text(
          '6 hours ago',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class _buildReplyButton extends StatelessWidget {
  const _buildReplyButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                // color: Colors.amber,
                border: Border.symmetric(
                    vertical:
                        BorderSide(width: 1, color: Colors.grey.shade300))),
            child: Container(height: 12.0),
          ),
          Container(
            // decoration: BoxDecoration(color: Colors.redAccent),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: onPressed,
                child: Text('Reply', style: TextStyle(fontSize: 12.0))),
          ),
        ],
      ),
    );
  }
}

class _buildCommentContent extends StatelessWidget {
  const _buildCommentContent({
    Key? key,
    this.commentContent,
  }) : super(key: key);

  final String? commentContent;

  @override
  Widget build(BuildContext context) {
    const sampleCommentContent =
        'A paragraph is a collection of words strung together to make a longer unit than a sentence. Several sentences often make a paragraph. There are normally three to eight sentences in a paragraph. Paragraphs can start with a five-space indentation or by skipping a line and then starting over. This makes it simpler to tell when one paragraph ends and the next starts simply it has 3-9 lines≥≤?';
    debugPrint(commentContent);
    return Row(
      children: [
        Expanded(
          child: Text(
            commentContent ?? sampleCommentContent,
            style: TextStyle(color: Color.fromARGB(255, 56, 55, 55)),
          ),
        ),
      ],
    );
  }
}
