import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import 'Comment.dart';
import 'package:intl/intl.dart';

class ArticlePost {
  String? id;
  String? title;
  DateTime? created_at;
  String? content;
  List<String>? categories;
  String? author_id;
  List<String>? liked_users;
  List<Comment>? comments;

  ArticlePost(this.id, this.title, this.created_at, this.content,
      this.categories, this.author_id, this.liked_users, this.comments);

  ArticlePost.only({
    this.id,
    this.title,
    this.created_at,
    this.content,
    this.categories,
    this.author_id,
    this.liked_users,
    this.comments,
  });

  factory ArticlePost.test() {
    var id = 'id_test';
    var comments = [
      Comment(content: 'sample comment 1'),
      Comment(content: 'sample comment 2')
    ];
    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test article';
    return ArticlePost.only(
      id: id,
      comments: comments,
      content: content,
      created_at: created_at,
      title: title,
    );
  }

  void setId(String? id) => this.id = id;

  void setAuthorId(String? id) => author_id = id;

  factory ArticlePost.fromJson(Map<String, dynamic>? data) {
    final String? id = data?['id'];
    final String? title = data?['title'];

    final String? date_string_created = data?['created_at'];
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    // final DateTime created_at =
    //     formatter.parse(date_string_created ?? '1/1/2001');
    final DateTime created_at =
        DateTime.parse(date_string_created ?? '1/1/2001');

    final String? content = data?['content'];
    final List<String>? categories =
        data?['categories'] is Iterable ? List.from(data?['categories']) : null;
    final String? author_id = data?['author_id'];
    final List<String>? liked_users = data?['liked_users'] is Iterable
        ? List.from(data?['liked_users'])
        : null;
    final List<Comment>? comments =
        data?['comments'] is Iterable ? List.from(data?['comments']) : null;

    return ArticlePost(id, title, created_at, content, categories, author_id,
        liked_users, comments);
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (title != null) 'title': title,
        if (created_at != null) 'created_at': created_at.toString(),
        if (content != null) 'content': content,
        if (categories != null) 'categories': categories,
        if (author_id != null) 'author_id': author_id,
        if (liked_users != null) 'liked_users': liked_users,
        if (comments != null) 'comments': comments,
      };

  void addLikedUser(String userId) {
    if (liked_users == null) {
      liked_users = <String>[];
    }
    liked_users!.add(userId);
  }

  void addCategories(String category) {
    if (categories == null) {
      categories = <String>[];
    }
    categories!.add(category);
  }

  int get numberOfLile {
    return liked_users?.length ?? 0;
  }

  static List<ArticlePost> getSampleArticlePostList() {
    var listCategory = <String>['Algorithm', 'Java'];
    var listAccount = <String>['id1', 'id2', 'id3'];
    var listComment = Comment.getSampleCommentsList();
    List<ArticlePost> _post = <ArticlePost>[];
    List<ArticlePost>? _post2;
    _post.add(ArticlePost(
        '1',
        'What clothes we should use in the interview day',
        DateTime.now(),
        'Clothes are one of the easiest impressive point to the interviewers',
        listCategory,
        'authorid1',
        listAccount,
        listComment));

    return _post;
    // await DatabaseService().getArticlesList().then((value) {
    //   _post2 = value;
    //   print(_post2);
    // });
    // return _post2 ?? _post;
    // return DatabaseService().getArticlesList() ?? _post;
  }
}
