import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'Comment.dart';
import 'package:intl/intl.dart';

class ExperiencePost {
  String? post_id;
  String? topic_id;
  String? title;
  DateTime? created_at;
  String? content;
  List<String>? liked_users;
  List<Comment>? comments;
  int? number_of_view;

  ExperiencePost(this.post_id, this.topic_id, this.title, this.created_at,
      this.content, this.liked_users, this.comments, this.number_of_view);
  ExperiencePost.only(
      {this.post_id,
        this.topic_id,
        this.title,
        this.created_at,
        this.content,
        this.liked_users,
        this.comments,
        this.number_of_view});

  void setPostId(String? id) {
    this.post_id = id;
  }

  void setTopicId(String? id) {
    this.topic_id = id;
  }

  void setComments(List<Comment>? comments) => this.comments = comments;


  factory ExperiencePost.test() {
    var idPost = 'id_post';
    var comments = [
      Comment(content: 'sample comment 1'),
      Comment(content: 'sample comment 2')
    ];
    var likes = ['bakakAcsaCB'];
    var idTopic = 'id_topic';
    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test experience';
    var number_of_view = 10;
    return ExperiencePost.only(
      post_id: idPost,
      topic_id: idTopic,
      title: title,
      content: content,
      created_at: created_at,
      comments: comments,
      liked_users: likes,
      number_of_view: number_of_view,
    );
  }

  factory ExperiencePost.fromJson(Map<String, dynamic>? data) {
    final String? post_id = data?['post_id'];
    final String? topic_id = data?['topic_id'];
    final String? title = data?['title'];
    final String? date_string_created = data?['created_at'];
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime created_at = DateTime.parse(
        date_string_created ?? DateTime.utc(2001, 1, 1).toString());
    final String? content = data?['content'];
    List<String>? liked_users = data?['liked_users'] is Iterable
        ? List.from(data?['liked_users'])
        : null;

    // final List<Comment>? comments =
    // data?['comments'] is Iterable ? List.from(data?['comments']) : null;

    final List<Comment>? comments =
    [
      Comment(content: 'sample comment 1'),
      Comment(content: 'sample comment 2')
    ];
    final int? number_of_view = data?['number_of_view'];
    final String? author_id = data?['author_id'];

    return ExperiencePost.only(
      post_id: post_id,
      topic_id: topic_id,
      title: title,
      created_at: created_at,
      content: content,
      liked_users: liked_users,
      comments: comments,
      number_of_view: number_of_view,
    );
  }

  factory ExperiencePost.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return ExperiencePost.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    if (post_id != null) 'post_id': post_id,
    if (topic_id != null) 'topic_id': topic_id,
    if (title != null) 'title': title,
    if (created_at != null) 'created_at': created_at,
    if (content != null) 'content': content,
    if (liked_users != null) 'liked_users': liked_users,
    if (comments != null) 'comments': comments,
    if (number_of_view != null) 'number_of_view': number_of_view,
  };

  void addLikedUser(String userId) {
    if (liked_users == null) {
      liked_users = <String>[];
    }
    liked_users!.add(userId);
  }

  int get numberOfLike {
    return liked_users?.length ?? 0;
  }

  @override
  String toString() {
    return '${this.title} , ${this.content}';
  }

  static List<ExperiencePost> getSampleExperiencePostList() {
    List<ExperiencePost>? _post = [];
    _post.add(ExperiencePost('1', '1', 'Chia sẻ về một số kinh nghiệm phỏng vấn tại công ty ABC', DateTime.now(), 'Hôm nay tôi đi phỏng vấn',
        [], [], 0));
    return _post;
  }


}
