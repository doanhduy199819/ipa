// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/comment/comment_input.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/pages/components/comment/comment_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/components/article_comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/more-options_button.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../objects/FirestoreUser.dart';
import '../../../../objects/ArticlePost.dart';
import '../../../../objects/Comment.dart';

class ArticleCommentsPart extends StatefulWidget {
  String articleId;
  ArticleCommentsPart({Key? key, required this.articleId}) : super(key: key);

  @override
  State<ArticleCommentsPart> createState() => _ArticleCommentsPartState();
}

class _ArticleCommentsPartState extends State<ArticleCommentsPart> {
  late Stream<List<Comment>?> _stream;

  @override
  void initState() {
    _stream = DatabaseService().commentsFromArticle(widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          List<Comment>? comments = asyncSnapshot.data;
          return Helper.handleSnapshot(asyncSnapshot) ??
              Column(
                children: [
                  _buildHeading(numberOfComments: comments?.length ?? 0),
                  SizedBox(
                    height: 10,
                  ),
                  CommentInput(
                    scrollController:
                        MyInheritedData.of(context).scrollController,
                    onSendButtonPressed: (content) => DatabaseService()
                        .addCommentToArticle(content, widget.articleId),
                  ),
                  Divider(),
                  _buildCommentsList(
                    comments: comments,
                    articleId: widget.articleId,
                  ),
                ],
              );
        });
  }
}

// ignore: camel_case_types
class _buildCommentsList extends StatelessWidget {
  const _buildCommentsList({
    Key? key,
    required this.comments,
    required this.articleId,
  }) : super(key: key);

  final List<Comment>? comments;
  final String articleId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...?comments
            ?.map((comment) => ArticleComment(
                  comment: comment,
                  articleId: articleId,
                ))
            .toList()
      ],
    );
  }
}

// ignore: camel_case_types
class _buildHeading extends StatelessWidget {
  const _buildHeading({
    Key? key,
    required this.numberOfComments,
  }) : super(key: key);

  final int numberOfComments;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Comments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Positioned(
            top: -4,
            right: -24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(numberOfComments.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}
