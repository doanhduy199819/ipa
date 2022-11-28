import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/bookmark.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class QuestionBookmarkIcon extends StatelessWidget {
  const QuestionBookmarkIcon({Key? key, required this.question})
      : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return BookmarkIcon(onBookmarkChange: (isActive) {
      isActive
          ? DatabaseService().saveQuestion(question)
          : DatabaseService().unSaveQuestion(question);
    });
  }
}
