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

  ArticlePost(
      {required this.title,
      required this.detail,
      required this.bookmark,
      required this.favorite,
      required this.time,
      required this.comment,
      required this.account,
      required this.love});

  static List<ArticlePost> getSampleArticlePostList() {
    var _post = <ArticlePost>[];
    _post
      ..add(ArticlePost(
          title: 'What clothes we should use in the interview day',
          detail:
              'Clothes are one of the easiest impressive point to the interviewers',
          bookmark: true,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'OOP is a must for a C++ developer',
          detail:
              'Most of us have studied Object-Oriented Programming at the university',
          bookmark: false,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'Apple SDE Sheet: Interview Question & Answer',
          detail:
              'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies',
          bookmark: true,
          favorite: 2871,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)',
          detail:
              'Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi ',
          bookmark: true,
          favorite: 666,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: true))
      ..add(new ArticlePost(
          title: 'What clothes we should use in the interview day',
          detail:
              'Clothes are one of the easiest impressive point to the interviewers',
          bookmark: true,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'OOP is a must for a C++ developer',
          detail:
              'Most of us have studied Object-Oriented Programming at the university',
          bookmark: false,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: true))
      ..add(new ArticlePost(
          title: 'Apple SDE Sheet: Interview Question & Answer',
          detail:
              'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies',
          bookmark: true,
          favorite: 2871,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)',
          detail: 'Nguyen Duy Nhat Tan luoi viet lam roi....',
          bookmark: true,
          favorite: 666,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'What clothes we should use in the interview day',
          detail:
              'Clothes are one of the easiest impressive point to the interviewers',
          bookmark: true,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: true))
      ..add(new ArticlePost(
          title: 'OOP is a must for a C++ developer',
          detail:
              'Most of us have studied Object-Oriented Programming at the university',
          bookmark: false,
          favorite: 1412,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: true))
      ..add(new ArticlePost(
          title: 'Apple SDE Sheet: Interview Question & Answer',
          detail:
              'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies',
          bookmark: true,
          favorite: 2871,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: false))
      ..add(new ArticlePost(
          title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)',
          detail: 'Nguyen Duy Nhat Tan luoi viet lam roi....',
          bookmark: true,
          favorite: 666,
          time: '28/07/2022',
          comment: Comment.getSampleCommentsList(),
          account: listAccount[1],
          love: true));

    return _post;
  }
}
