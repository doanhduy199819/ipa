// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/comment_input.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/pages/components/comment_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/more-options_button.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../objects/FirestoreUser.dart';
import '../../../objects/ArticlePost.dart';
import '../../../objects/Comment.dart';

class ArticleCommentPart extends StatefulWidget {
  String articleId;
  ArticleCommentPart({Key? key, required this.articleId}) : super(key: key);

  @override
  State<ArticleCommentPart> createState() => _ArticleCommentPartState();
}

class _ArticleCommentPartState extends State<ArticleCommentPart> {
  late Stream<List<Comment>?> _stream;

  @override
  void initState() {
    // TODO: implement initState
    _stream = DatabaseService().commentsFromArticle(widget.articleId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        // stream: DatabaseService().commentsFromArticle(widget.articleId),
        stream: _stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          List<Comment>? comments = asyncSnapshot.data;
          return Helper().handleSnapshot(asyncSnapshot) ??
              Column(
                children: [
                  _commentHeading(numberOfComments: comments?.length ?? 0),
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
                  commentsList(comments),
                ],
              );
        });
  }

  // List of comments of this article
  Widget commentsList(List<Comment>? comments) {
    return Column(
      children: <Widget>[
        // ...?comments?.map((comment) => commentBloc(comment)).toList()
        ...?comments
            ?.map((comment) => ArticleCommentInput(
                  comment: comment,
                  articleId: widget.articleId,
                ))
            .toList()
      ],
    );
  }
}

class _commentHeading extends StatelessWidget {
  const _commentHeading({
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

class ArticleCommentInput extends StatefulWidget {
  const ArticleCommentInput(
      {Key? key, required this.comment, required this.articleId})
      : super(key: key);

  final Comment comment;
  final String articleId;

  @override
  State<ArticleCommentInput> createState() => _ArticleCommentInputState();
}

class _ArticleCommentInputState extends State<ArticleCommentInput> {
  late Future<FirestoreUser?> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future =
        DatabaseService().getFirestoreUser(widget.comment.author_id ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot<FirestoreUser?> asyncSnapshot) =>
          Helper().handleSnapshot(asyncSnapshot) ??
          CommentBoxWidget(
              photoUrl: asyncSnapshot.data?.photoUrl,
              userName: asyncSnapshot.data?.displayName,
              content: widget.comment.content,
              postFix: MoreOptionsDropDownButton(
                comment: widget.comment,
                onDelete: () => DatabaseService().deleteCommentFromArticle(
                    widget.comment.id!, widget.articleId),
              )),
    );
  }
}
