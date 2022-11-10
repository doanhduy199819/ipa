import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';

mixin CommentService {
  Future<void> addCommentToArticle(String content, String articleId);
  Future<void> deleteCommentFromArticle(String commentId, String articleId);
  List<Comment>? commentsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot);

  Stream<List<Comment>?> commentsFromArticle(String aricleId);
}
