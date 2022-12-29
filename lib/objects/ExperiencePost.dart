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
  bool? isApproved=false;
  String? author_name;

  ExperiencePost(
      this.post_id,
      this.topic_id,
      this.title,
      this.created_at,
      this.content,
      this.liked_users,
      this.comments,
      this.number_of_view,
      this.isApproved,
      this.author_name,
      );
  ExperiencePost.only(
      {this.post_id,
        this.topic_id,
        this.title,
        this.created_at,
        this.content,
        this.liked_users,
        // this.comments,
        this.number_of_view,
        this.isApproved,
        this.author_name,});

  void setPostId(String? id) {
    this.post_id = id;
  }

  void setTopicId(String? id) {
    this.topic_id = id;
  }

  void setComments(List<Comment>? comments) => this.comments = comments;

  int get numberOfComments {
    return comments?.length ?? 0;
  }

  void setAuthorName(String? name){
    this.author_name=name;
  }

  factory ExperiencePost.test() {
    var idPost = 'id_post';
    var comments = [
      Comment(content: 'sample comment 1'),
      Comment(content: 'sample comment 2')
    ];
    //var likes = ['bakakAcsaCB'];
    var idTopic = 'id_topic';
    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test experience';
    var number_of_view = 10;
    var isApproved=false;
    var author_name='NONAME';
    return ExperiencePost.only(
      post_id: idPost,
      topic_id: idTopic,
      title: title,
      content: content,
      created_at: created_at,
      //liked_users: likes,
      number_of_view: number_of_view,
      isApproved:isApproved,
      author_name: author_name,
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

    // final List<Comment>? comments =
    // [
    //   Comment(content: 'sample comment 1'),
    //   Comment(content: 'sample comment 2')
    // ];
    final int? number_of_view = data?['number_of_view'];
    final bool? isApproved=data?['isApproved'];
    final String? author_name= data?['author_name'];
    // final String? author_id = data?['author_id'];

    // return ExperiencePost.only(
    //   post_id: post_id,
    //   topic_id: topic_id,
    //   title: title,
    //   created_at: created_at,
    //   content: content,
    //   liked_users: liked_users,
    //   number_of_view: number_of_view,
    // );
    return ExperiencePost(post_id, topic_id, title, created_at, content, liked_users, null, number_of_view,isApproved,author_name);
  }


  factory ExperiencePost.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return ExperiencePost.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    if (post_id != null) 'post_id': post_id,
    if (topic_id != null) 'topic_id': topic_id,
    if (title != null) 'title': title,
    if (created_at != null) 'created_at': created_at.toString(),
    if (content != null) 'content': content,
    if (liked_users != null) 'liked_users': liked_users,
    if (comments != null) 'comments': comments,
    if (number_of_view != null) 'number_of_view': number_of_view,
    if(isApproved!=null) 'isApproved':isApproved,
    if(author_name != null) 'author_name':author_name,
  };

  void addLikedUser(String userId) {
    if (liked_users == null) {
      liked_users = <String>[];
    }
    liked_users!.add(userId);
  }

  String displayLikedUsers() {
    String rs = '';
    liked_users?.map((element) {
      rs += element;
    });
    return rs;
  }

  int get numberOfLike {
    return liked_users?.length ?? 0;
  }

  @override
  String toString() {
    return '${this.title} , ${this.content} , Like: ${liked_users?.length ?? 0}';
  }

  static List<ExperiencePost> getSampleExperiencePostList() {
    List<ExperiencePost>? _post = [];
    _post.add(ExperiencePost('1', '1', 'Chia sẻ về một số kinh nghiệm phỏng vấn tại công ty ABC', DateTime.now(), 'Hôm nay tôi đi phỏng vấn',
        [], [], 0,false,'hehe'));
    return _post;
  }

}

