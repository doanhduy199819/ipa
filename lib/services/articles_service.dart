import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

mixin ArticlePostHandle {
  FirebaseFirestore db = FirebaseFirestore.instance;

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
    return db
        .collection('articles')
        .snapshots()
        .map(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> get allArticlesOnce {
    return db.collection('articles').get().then(_articlesFromQuerySnapshot);
  }

  void addListArticles(List<ArticlePost> list) {
    CollectionReference collection = db.collection('articles');
    list.forEach((article) {
      collection
          .add(article.toJson())
          .then((value) => print('Article added successfully'))
          .catchError((onError) => print('Failed to add an article'));
    });
  }

  void addArticle(ArticlePost article) async {
    DocumentReference doc = db.collection('articles').doc();
    String doc_id = doc.id;
    if (article.id == null) article.setId(doc_id);
    String? user_id = AuthService().currentUserId;
    article.setAuthorId(user_id);
    CollectionReference subcollection =
        db.collection('articles').doc(doc_id).collection('comments');
    article.comments?.forEach((element) => subcollection.add(element.toJson()));
    print(article.comments);

    doc
        .set(article.toJson())
        .then((value) => print('Article added successfully'))
        .catchError((error) => print('Failed to add an article'));
  }
}
