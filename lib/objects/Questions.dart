import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'Account.dart';
import 'package:intl/intl.dart';

class Question {
  String? id;
  String? title;
  String? content;
  DateTime? created_at;
  String? author_id;
  String? company_id;
  List<String>? categories;
  List<String>? upvote_users;
  List<String>? downvote_users;
  List<Comment>? answers;

  Question(
    this.id,
    this.title,
    this.content,
    this.created_at,
    this.author_id,
    this.company_id,
    this.categories,
    this.upvote_users,
    this.downvote_users,
    this.answers,
  );

  Question.only({
    this.id,
    this.title,
    this.content,
    this.created_at,
    this.author_id,
    this.company_id,
    this.categories,
    this.upvote_users,
    this.downvote_users,
    this.answers,
  });

  factory Question.test() {
    var id = 'id_test';
    var comments = [
      Comment(content: 'sample comment 1'),
      Comment(content: 'sample comment 2')
    ];
    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test questions';
    return Question.only(
      id: id,
      answers: comments,
      content: content,
      created_at: created_at,
      title: title,
    );
  }
  // {
  //   this.categories = <String>[];
  //   this.upvote_users = <String>[];
  //   this.downvote_users = <String>[];
  //   this.answers = <Comment>[];
  // }

  void setId(String? id) => this.id = id;
  void setAuthorId(String? id) => author_id = id;

  factory Question.fromJson(Map<String, dynamic>? json) {
    final String? id = json?['id'];
    final String? title = json?['title'];
    final String? content = json?['content'];
    final String? date_string_created = json?['created_at'];
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime created_at =
        formatter.parse(date_string_created ?? '1/1/2001');
    final String? author_id = json?['author_id'] as String?;
    final String? company_id = json?['company_id'] as String?;
    final List<String>? categories =
        json?['categories'] is Iterable ? List.from(json?['categories']) : null;

    final List<String>? upvote_users = json?['upvote_users'] is Iterable
        ? List.from(json?['upvote_users'])
        : null;

    final List<String>? downvote_users = json?['downvote_users'] is Iterable
        ? List.from(json?['downvote_users'])
        : null;

    final List<Comment>? answers =
        json?['answers'] is Iterable ? List.from(json?['answers']) : null;

    return Question(id, title, content, created_at, author_id, company_id,
        categories, upvote_users, downvote_users, answers);
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (title != null) 'title': title,
        if (content != null) 'content': content,
        if (created_at != null) 'created_at': created_at,
        if (author_id != null) 'author_id': author_id,
        if (company_id != null) 'company_id': company_id,
        if (categories != null) 'categories': categories,
        if (upvote_users != null) 'upvote_users': upvote_users,
        if (downvote_users != null) 'downvote_users': downvote_users,
        if (answers != null) 'answers': answers,
      };

  void addUpvoteUser(String userId) {
    if (upvote_users == null) {
      upvote_users = <String>[];
    } else {
      upvote_users!.add(userId);
    }
  }

  void addDownvoteUser(String userId) {
    if (downvote_users == null) {
      downvote_users = <String>[];
    } else {
      downvote_users!.add(userId);
    }
  }

  void addAnswer(Comment comment) {
    if (answers == null) {
      downvote_users = <String>[];
    } else {
      answers!.add(comment);
    }
  }

  int get numberOfUpvote {
    return (upvote_users?.length ?? 0);
  }

  int get numberOfDownvote {
    return (downvote_users?.length ?? 0);
  }

  int get numberOfAnswers {
    return (answers?.length ?? 0);
  }

  static List<Question> getSampleQuestion() {
    List<Question> _sampleQuestion = [];
    _sampleQuestion
      ..add(Question(
        '0',
        'Remove duplicate',
        'This is content remove duplicate',
        DateTime(2021, 10, 11, 20, 30),
        '100',
        '1',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
        Comment.getSampleCommentsList(),
      ))
      ..add(Question(
        '1',
        'Remove duplicate character in string',
        'This is content remove duplicate',
        DateTime(2021, 10, 11, 20, 30),
        '100',
        '1',
        ['c++', 'string', 'algorithm'],
        ['0', '1', '2'],
        ['5'],
        Comment.getSampleCommentsList(),
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
        Comment.getSampleCommentsList(),
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
        Comment.getSampleCommentsList(),
      ));
    return _sampleQuestion;
  }

}
