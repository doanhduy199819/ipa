import 'package:flutter_interview_preparation/objects/Account.dart';

import 'Comment.dart';

class ArticlePost {
  String title;
  String detail;
  bool bookmark;
  int favorite;
  String time;
  List<Comment> comment;
  Account account;
  bool love;

  ArticlePost({required this.title,required this.detail,required this.bookmark,required this.favorite,required this.time,required this.comment,required this.account,required this.love});
}