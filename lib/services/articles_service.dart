import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/UserData.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/saved_articles.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

mixin ArticlePostHandle {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ArticlePost>? _articlesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ArticlePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ArticlePost.test();
    }).toList();
  }

  Stream<List<ArticlePost>?> get allArticles {
    return _db
        .collection('articles')
        .orderBy('created_at')
        .limit(10)
        .snapshots()
        .map(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> get allArticlesOnce {
    return _db
        .collection('articles')
        .orderBy('created_at')
        .limit(10)
        .get()
        .then(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> getArticlesWithIds(List<String>? ids) {
    return _db
        .collection('articles')
        .where("id", whereIn: ids)
        .get()
        .then(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> get savedArticles async {
    final docSnapshot = await _db
        .collection('users')
        .doc(AuthService().currentUser?.uid ?? '')
        .get();
    final userData = UserData.fromFirestore(docSnapshot);

    return await _db
        .collection('articles')
        .where("id", whereIn: userData.savedArticles)
        .get()
        .then(_articlesFromQuerySnapshot);
  }

  void addListArticles(List<ArticlePost> list) {
    list.forEach((article) => addArticle(article));
  }

  void addArticle(ArticlePost article) async {
    DocumentReference doc = _db.collection('articles').doc();
    String doc_id = doc.id;
    if (article.id == null) article.setId(doc_id);
    String? user_id = AuthService().currentUserId;
    article.setAuthorId(user_id);

    // Add article comments to firebase
    CollectionReference subcollection =
        _db.collection('articles').doc(doc_id).collection('comments');
    article.comments?.forEach((element) => subcollection.add(element.toJson()));

    // Add article to firebase
    doc
        .set(article.toJson())
        .then((value) => print('Article added successfully'))
        .catchError((error) => print('Failed to add an article'));
  }

  void postSampleArticle() {
    ArticlePost articlePost =
        ArticlePost.only(title: 'Testing comments', content: 'Nothing much');
    articlePost.comments = Comment.getSampleCommentsList();
    addArticle(articlePost);
  }

  Future<List<ArticlePost>?> getArticlesList() async {
    CollectionReference collection = _db.collection('articles');
    // return a QuerySnapshot, which is a collection query
    // To access documents in a collection,
    // querySnapshot.docs() => return a List<DocumentSnapshot>
    List<ArticlePost>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.first.data());
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          ArticlePost a = ArticlePost.fromJson(data);
          return a;
        }
        return ArticlePost.test();
      }).toList();
    });
    return result;
  }

  Stream<ArticlePost> getArticle(String articleId) {
    return _db
        .collection('articles')
        .doc(articleId)
        .snapshots()
        .map(ArticlePost.fromDocumentSnapshot);
  }

  Stream<bool> isArticlePostLiked(String articlePostId) {
    return _db
        .collection('articles')
        .doc(articlePostId)
        .snapshots()
        .map((documenSnapshot) {
      final data = documenSnapshot.data();
      List<String>? likedUsers = data?['liked_users'] is Iterable
          ? List.from(data?['liked_users'])
          : null;
      return likedUsers?.contains(AuthService().currentUserId) ?? false;
    });
  }

  Stream<bool> isArticlePostSaved(String articlePostId) {
    return _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .snapshots()
        .map((documenSnapshot) {
      final data = documenSnapshot.data();
      List<String>? savedArticlesIds = data?['savedArticles'] is Iterable
          ? List.from(data?['savedArticles'])
          : null;
      return savedArticlesIds?.contains(articlePostId) ?? false;
    });
  }

  Future<void> likeArticle(String articleId) async {
    _db
        .collection('articles')
        .doc(articleId)
        .update({
          "liked_users": FieldValue.arrayUnion([AuthService().currentUserId]),
        })
        .then((_) => debugPrint('Like article completed: $articleId'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }

  Future<void> unLikeArticle(String articleId) async {
    _db
        .collection('articles')
        .doc(articleId)
        .update({
          "liked_users": FieldValue.arrayRemove([AuthService().currentUserId]),
        })
        .then((_) => debugPrint('Remove liked article completed: $articleId'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }

  Future<void> saveArticle(ArticlePost article) async {
    _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .update({
          "savedArticles": FieldValue.arrayUnion([article.id]),
        })
        .then((_) => debugPrint('Save article completed: ${article.id}'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }

  Future<void> unSaveArticle(ArticlePost article) async {
    _db
        .collection('users')
        .doc(AuthService().currentUserId)
        .update({
          "savedArticles": FieldValue.arrayRemove([article.id]),
        })
        .then(
            (_) => debugPrint('Remove saved article completed: ${article.id}'))
        .onError(
            (error, stackTrace) => debugPrint('Error ${error.toString()}'));
  }
}
