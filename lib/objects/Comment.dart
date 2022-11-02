import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:intl/intl.dart';

class Comment {
  String? id;
  String? author_id;
  String? content;
  final DateTime? created_at;
  List<String>? upvote_users;
  List<String>? downvote_users;
  bool is_accepted;

  Comment({
    this.id,
    this.author_id,
    this.content,
    this.created_at,
    this.upvote_users = const <String>[],
    this.downvote_users = const <String>[],
    this.is_accepted = false,
  });

  factory Comment.fromJson(Map<String, dynamic>? data) {
    final String? id = data?['id'];
    final String? author_id = data?['author_id'];
    final String? content = data?['content'];
    final List<String>? upvote_users = data?['upvote_users'] is Iterable
        ? List.from(data?['upvote_users'])
        : null;
    final List<String>? downvote_users = data?['downvote_users'] is Iterable
        ? List.from(data?['downvote_users'])
        : null;
    final bool is_accepted = data?['is_accepted'];

    final String? date_string_created = data?['created_at'] as String?;
    // DateFormat formatter = DateFormat('dd/MM/yyyy');
    final DateTime created_at =
        DateTime.parse(date_string_created ?? DateTime.utc(2001,1,1).toString());
    // formatter.parse(date_string_created ?? '1/1/2001');

    return Comment(
        id: id,
        author_id: author_id,
        content: content,
        created_at: created_at,
        upvote_users: upvote_users,
        downvote_users: downvote_users,
        is_accepted: is_accepted);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author_id': author_id,
        'content': content,
        'created_at': created_at.toString(),
        'upvote_users': upvote_users,
        'downvote_users': downvote_users,
        'is_accepted': is_accepted
      };

  void addUpvoteUser(String userId) {
    if (upvote_users == null) upvote_users = <String>[];
    upvote_users!.add(userId);
  }

  void addDownvoteUser(String userId) {
    if (downvote_users == null) upvote_users = <String>[];
    downvote_users!.add(userId);
  }

  void setAccepted(bool is_accepted) {
    this.is_accepted = is_accepted;
  }

  int get upvote {
    return (upvote_users?.length ?? 0);
  }

  int get downvote {
    return (downvote_users?.length ?? 0);
  }

  static List<Comment> getSampleCommentsList() {
    List<Comment> list = [
      Comment(
          content: 'Sau tat ca minh lai tro ve voi nhau',
          created_at: DateTime.now()),
      Comment(
          content: 'Nang vuong tren canh hong kho nhung ki niem xua kia',
          created_at: DateTime.now()),
      Comment(
          content: 'Chieu mua ben hien vang buon', created_at: DateTime.now()),
      Comment(
          content: 'Dieu anh luon giu kin trong tim',
          created_at: DateTime.now()),
      Comment(
          content: 'Teo teo teo teo teo teo teo teo teo teo teo teo',
          created_at: DateTime.now()),
    ];
    return list;
  }
}
