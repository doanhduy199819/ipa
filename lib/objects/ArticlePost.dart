import 'package:flutter_interview_preparation/objects/Account.dart';

import 'Comment.dart';
import 'package:intl/intl.dart';

class ArticlePost {
  String? id;
  String? title;
  DateTime? created_at;
  String? content;
  List<String> categories;
  String? author_id;
  List<String> liked_users;
  List<Comment> comments;

  ArticlePost(this.id, this.title, this.created_at, this.content,
      this.categories, this.author_id, this.liked_users, this.comments);

  ArticlePost.only({
    this.id,
    this.title,
    this.created_at,
    this.content,
    this.categories = const <String>[],
    this.author_id,
    this.liked_users = const <String>[],
    this.comments = const <Comment>[],
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

  void setId(String id) => this.id = id;

  factory ArticlePost.fromJson(Map<String, dynamic> data) {
    final String? id = data['id'] as String?;
    final String? title = data['title'] as String?;

    final String? date_string_created = data['created_at'] as String?;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime created_at =
        formatter.parse(date_string_created ?? '1/1/2001');

    final String? content = data['content'] as String;
    final List<String> categories = data['categories'] as List<String>;
    final String? author_id = data['author_id'] as String;
    final List<String> liked_users = data['liked_users'] as List<String>;
    final List<Comment> comments = data['comments'] as List<Comment>;

    return ArticlePost(id, title, created_at, content, categories, author_id,
        liked_users, comments);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'post_time': created_at.toString(),
        'content': content,
        'categories': categories,
        'author_id': author_id,
        'liked_users': liked_users,
        'comments': comments,
      };

  void addLikedUser(String userId) => liked_users.add(userId);

  void addCategories(String category) => categories.add(category);

  int get numberOfLile {
    return (liked_users?.length ?? 0);
  }

  static List<ArticlePost> getSampleArticlePostList() {
    var listCategory = <String>['Algorithm', 'Java'];
    var listAccount = <String>['id1', 'id2', 'id3'];
    var listComment = Comment.getSampleCommentsList();
    var _post = <ArticlePost>[];
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
  }
}
