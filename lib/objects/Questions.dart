import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'Account.dart';

class Question {
  Account? author;
  int? upvote;
  List<Comment>? comment;
  String? title;
  List<String>? tags = [];
  String? content;
  String? company;
  String? time;

  Question(this.author, this.upvote, this.comment, this.title, this.tags,
      this.content, this.company, this.time);
  @override
  String toString() {
    return '$title';
  }
}

List<Question> listQuestion = [
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicateRemove duplicate",
      ['algorithms', 'string'],
      'This is contentThis is contentThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTs',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is contentThis is contentThis is contentThis is contentTs',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is contentThis is contentThis is contentThis is contentTs',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
  Question(
      listAccount[0],
      12,
      Comment.getSampleCommentsList(),
      "Remove duplicate",
      ['algorithms', 'string'],
      'This is content',
      HomeScreenAssets.lgLogo,
      '10/10/2022'),
];
