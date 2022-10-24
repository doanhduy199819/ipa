import 'package:flutter_interview_preparation/objects/Account.dart';

import 'Comment.dart';
import 'package:intl/intl.dart';


class ArticlePost {
  String? id;
  String? title;
  DateTime? post_time;
  String? content;
  List<String>? categories;
  String? author_id;
  List<String>? liked_users;
  List<Comment>? comments;

  ArticlePost(

        this.id,
        this.title,
       this.post_time,
      this.content,
        this.categories,
        this.author_id,
        this.liked_users,
        this.comments
           );

  factory ArticlePost.fromJson(Map<String, dynamic> data) {
    final String? id = data['id'] as String?;
    final String? title = data['title'] as String?;

    final String? date_string_created = data['post_time'] as String?;
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime post_time =
    formatter.parse(date_string_created ?? '1/1/2001');

    final String? content= data['content'] as String;
    final List<String> categories = data['categories'] as List<String>;
    final String? author_id= data['author_id'] as String;
    final List<String> liked_users = data['liked_users'] as List<String>;
    final List<Comment> comments = data['comments'] as List<Comment>;


    return ArticlePost(id, title, post_time, content, categories, author_id, liked_users, comments);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'post_time':post_time,
    'content':content,
    'categories': categories,
    'author_id': author_id,
    'liked_users': liked_users,
    'comments': comments,
  };

  void addLikedUser(String userId) => liked_users!.add(userId);

  void addCategories(String category)=>categories!.add(category);

  int get numberOfLile {
    return (liked_users?.length ?? 0);
  }

static List<ArticlePost> getSampleArticlePostList() {
    var listCategory=<String>['Algorithm','Java'];
    var listAccount=<String>['id1','id2','id3'];
    var listComment=Comment.getSampleCommentsList();
    var _post = <ArticlePost>[];
    _post.add(ArticlePost('1','What clothes we should use in the interview day',
        DateTime.now(),
        'Clothes are one of the easiest impressive point to the interviewers',listCategory,'authorid1',listAccount,listComment
    ));

    return _post;
  }
}
