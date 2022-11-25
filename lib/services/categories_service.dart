import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Categories.dart';

class CategoriesService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  // List<Categories>? getCategories(String? idJob) {
  //   CollectionReference collection =
  //       _db.collection('quizzes').doc(idJob).collection('categories');

  //   List<Categories>? result;
  //   collection.get().then((QuerySnapshot querySnapshot) {
  //     result = querySnapshot.docs
  //         .map((doc) {
  //           if (doc.exists) {
  //             Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
  //             Categories a = Categories.fromJson(data, doc.id);
  //             return a;
  //           }
  //           return Categories();
  //         })
  //         .cast<Categories>()
  //         .toList();
  //   });

  //   return result;
  // }

  List<Categories>? _categoriesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Categories.fromDocumentSnapshot(documentSnapshot);
      }
      return Categories();
    }).toList();
  }

  Stream<List<Categories>?> allCategories(String idJob) {
    return _db
        .collection('quizzes')
        .doc(idJob)
        .collection('categories')
        .snapshots()
        .map(_categoriesFromQuerySnapshot);
  }

  Future<List<Categories>?> allCategoriesOnce(String idJob) {
    return _db
        .collection('quizzes')
        .doc(idJob)
        .collection('categories')
        .get()
        .then(_categoriesFromQuerySnapshot);
  }
}
