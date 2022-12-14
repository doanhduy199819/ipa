import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/comment/comment_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/more-options_button.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class ArticleComment extends StatefulWidget {
  const ArticleComment(
      {Key? key, required this.comment, required this.articleId})
      : super(key: key);

  final Comment comment;
  final String articleId;

  @override
  State<ArticleComment> createState() => _ArticleCommentState();
}

class _ArticleCommentState extends State<ArticleComment> {
  late Future<FirestoreUser?> _future;

  @override
  void initState() {
    _future =
        DatabaseService().getFirestoreUser(widget.comment.author_id ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot<FirestoreUser?> asyncSnapshot) =>
          Helper.handleSnapshot(asyncSnapshot) ??
          CommentBoxWidget(
            photoUrl: asyncSnapshot.data?.photoUrl,
            userName: asyncSnapshot.data?.displayName,
            content: widget.comment.content,
            postFix: MoreOptionsDropDownButton(
              comment: widget.comment,
              onDelete: () => DatabaseService().deleteCommentFromArticle(
                  widget.comment.id!, widget.articleId),
              idQuestion: widget.articleId,
            ),
            timeString:
                Helper.toFriendlyDurationTime(widget.comment.created_at),
          ),
    );
  }
}
