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
  List<String> categories;
  List<String> upvote_users;
  List<String> downvote_users;
  List<Comment> answers;

  Question({
    this.id,
    this.title,
    this.content,
    this.created_at,
    this.author_id,
    this.company_id,
    this.categories = const [],
    this.upvote_users = const [],
    this.downvote_users = const [],
    this.answers = const [],
  });
  // {
  //   this.categories = <String>[];
  //   this.upvote_users = <String>[];
  //   this.downvote_users = <String>[];
  //   this.answers = <Comment>[];
  // }

  factory Question.fromJson(Map<String, dynamic> json) {
    final String? id = json['id'] as String?;
    final String? title = json['title'] as String?;
    final String? content = json['content'] as String?;
    final String? date_string_created = json['created_at'] as String?;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime created_at =
        formatter.parse(date_string_created ?? '1/1/2001');
    final String? author_id = json['author_id'] as String?;
    final String? company_id = json['company_id'] as String?;
    final List<String> categories = json['categories'] as List<String>;
    final List<String> upvote_users = json['upvote_users'] as List<String>;
    final List<String> downvote_users = json['downvote_users'] as List<String>;
    final List<Comment> answers = json['answers'] as List<Comment>;
    return Question(
      id: id,
      title: title,
      content: content,
      created_at: created_at,
      author_id: author_id,
      company_id: company_id,
      categories: categories,
      upvote_users: upvote_users,
      downvote_users: downvote_users,
      answers: answers,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'created_at': created_at,
        'author_id': author_id,
        'company_id': company_id,
        'categories': categories,
        'upvote_users': upvote_users,
        'downvote_users': downvote_users,
        'answers': answers,
      };

  void addUpvoteUser(String userId) => upvote_users.add(userId);

  void addDownvoteUser(String userId) => downvote_users.add(userId);

  void addAnswer(Comment comment) => answers.add(comment);

  int get upvote {
    return (upvote_users.length);
  }

  int get downvote {
    return (downvote_users.length);
  }

  int get numberOfAnswers{
    return (answers.length);
  }

  static List<Question> getSampleQuestion() {
    List<Question> _sampleQuestion = [];
    _sampleQuestion
      ..add(Question(
        id: '0',
        title: 'Remove duplicate',
        content: 'This is content remove duplicate',
        created_at: DateTime(2021, 10, 11, 20, 30),
        author_id: '100',
        company_id: '1',
        categories: ['C++', 'C#', 'Algorithm'],
        upvote_users: ['0', '1', '2'],
        downvote_users: ['5'],
      ))
      ..add(Question(
        id: '1',
        title: 'Remove duplicate character in string',
        content: 'This is content remove duplicate',
        created_at: DateTime(2021, 10, 11, 20, 30),
        author_id: '100',
        company_id: '1',
        categories: ['c++', 'string', 'algorithm'],
        upvote_users: ['0', '1', '2'],
        downvote_users: ['5'],
      ))
      ..add(Question(
        id: '0',
        title: 'Cleaning up data where it repeats daily',
        content:
            'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        created_at: DateTime(2022, 4, 11, 9, 30),
        author_id: '101',
        company_id: '2',
        categories: ['C++', 'C#', 'Algorithm'],
        upvote_users: ['0', '1', '2'],
        downvote_users: ['5'],
      ))
      ..add(Question(
        id: '0',
        title: 'Cleaning up data where it repeats daily',
        content:
            'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        created_at: DateTime(2022, 4, 11, 9, 30),
        author_id: '101',
        company_id: '2',
        categories: ['C++', 'C#', 'Algorithm'],
        upvote_users: ['0', '1', '2'],
        downvote_users: ['5'],
      ));
    return _sampleQuestion;
  }

//   static List<Question> listQuestion = [
//   Question(
//       '0',
//       'Remove duplicate',
//       listComment,
//       "Remove duplicateRemove duplicate",
//       ['algorithms', 'string'],
//       'This is contentThis is contentThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTsntThis is contentThis is contentTs',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is contentThis is contentThis is contentThis is contentTs',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is contentThis is contentThis is contentThis is contentTs',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
//   Question(
//       listAccount[0],
//       12,
//       listComment,
//       "Remove duplicate",
//       ['algorithms', 'string'],
//       'This is content',
//       HomeScreenAssets.lgLogo,
//       '10/10/2022'),
// ];
}
