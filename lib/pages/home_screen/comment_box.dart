// ignore_for_file: prefer_const_constructors
// ignore: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/home_screen/interaction_icon.dart';

class CommentBoxWidget extends StatefulWidget {
  const CommentBoxWidget({Key? key}) : super(key: key);

  @override
  State<CommentBoxWidget> createState() => _CommentBoxWidgetState();
}

class _CommentBoxWidgetState extends State<CommentBoxWidget> {
  int upVoteNum = 10;
  int voteStat = 0;

  @override
  Widget build(BuildContext context) {
    // const commentContent = 'What a value lesson !';
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          _buildCommentContent(),
          const SizedBox(
            height: 12.0,
          ),
          _buildInteractions(
            voteNum: updateVoteNum,
            voteState: voteStat,
            upVoteTap: () => setState(() {
              if (voteStat == 1) {
                voteStat = 0;
              } else {
                voteStat = 1;
              }
            }),
            downVoteTap: () => setState(() {
              if (voteStat == -1) {
                voteStat = 0;
              } else {
                voteStat = -1;
              }
            }),
          ),
        ],
      ),
    );
  }

  int get updateVoteNum {
    return upVoteNum + voteStat;
  }
}

class _buildInteractions extends StatelessWidget {
  const _buildInteractions({
    Key? key,
    required this.voteNum,
    this.upVoteTap,
    this.downVoteTap,
    required this.voteState,
  }) : super(key: key);

  final int voteNum;
  final void Function()? upVoteTap;
  final void Function()? downVoteTap;
  final int voteState;

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        InterractionIcon(
          activeIconData: Icons.arrow_upward_rounded,
          onTap: upVoteTap,
          isActive: voteState == 1,
        ),
        const SizedBox(width: 12.0),
        Text(voteNum.toString()),
        const SizedBox(width: 12.0),
        InterractionIcon(
          activeIconData: Icons.arrow_downward_rounded,
          activeColor: Colors.red,
          onTap: downVoteTap,
          isActive: voteState == -1,
        ),
        const SizedBox(width: 12.0),
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
  }) : super(key: key);

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
                    vertical: BorderSide(width: 1, color: Colors.grey))),
            child: Container(height: 24.0),
          ),
          FlatButton(onPressed: () {}, child: Text('Reply')),
        ],
      ),
    );
  }
}

class _buildCommentContent extends StatelessWidget {
  const _buildCommentContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const commentContent =
        'A paragraph is a collection of words strung together to make a longer unit than a sentence. Several sentences often make a paragraph. There are normally three to eight sentences in a paragraph. Paragraphs can start with a five-space indentation or by skipping a line and then starting over. This makes it simpler to tell when one paragraph ends and the next starts simply it has 3-9 lines≥≤?';
    return Row(
      children: const [
        Expanded(
            child: Text(
          commentContent,
          style: TextStyle(color: Color.fromARGB(255, 56, 55, 55)),
        )),
      ],
    );
  }
}

class _buildTitle extends StatelessWidget {
  const _buildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageUrl = 'https://www.vietnamplus.vn/';
    const userName = 'Pikachu';
    const titleTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 8, 16),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 20.0,
          ),
        ),
        Text(
          userName,
          style: titleTextStyle,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
            ),
          ),
        ),
      ],
    );
  }
}
