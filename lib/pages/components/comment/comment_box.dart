// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/up_down_vote_box.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';

class CommentBoxWidget extends StatelessWidget {
  const CommentBoxWidget({
    Key? key,
    this.photoUrl,
    this.userName,
    this.content,
    this.fontSize = 12,
    this.postFix,
    this.defaultVoteState,
    this.voteNum,
    this.upVoteHandle,
    this.downVoteHandle,
    required this.timeString,
  }) : super(key: key);

  // For user info
  final String? photoUrl;
  final String? userName;

  // For content
  final String? content;
  final int? fontSize;

  // For custom postfix buttons
  final Widget? postFix;

  /// For up/down vote
  final int? defaultVoteState;
  final int? voteNum;
  final void Function(bool)? upVoteHandle;
  final void Function(bool)? downVoteHandle;

  // For time
  final String timeString;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoBox(
            photoUrl: photoUrl,
            userName: userName,
            postFix: postFix,
          ),
          _buildCommentContent(
            commentContent: content,
          ),
          // const SizedBox(height: 8.0),
          _buildInteractions(
            voteNum: voteNum,
            defaultVoteState: defaultVoteState,
            upVoteHandle: upVoteHandle,
            downVoteHandle: downVoteHandle,
            timeString: timeString,
          ),
          Divider(),
        ],
      ),
    );
  }
}

class _buildInteractions extends StatelessWidget {
  _buildInteractions({
    Key? key,
    this.voteNum,
    this.defaultVoteState = 0,
    this.upVoteHandle,
    this.downVoteHandle,
    required this.timeString,
  }) : super(key: key);

  final int? voteNum;
  final int? defaultVoteState;
  final String timeString;
  final void Function(bool)? upVoteHandle;
  final void Function(bool)? downVoteHandle;

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        if (voteNum != null) ...[
          UpDownVoteBox(
            voteNum: voteNum,
            defaultVoteState: defaultVoteState,
            upVoteHandle: upVoteHandle,
            downVoteHandle: downVoteHandle,
          ),
        ],
        _buildReplyButton(),
        const SizedBox(width: 16.0),
        Text(
          timeString,
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
