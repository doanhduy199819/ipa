import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/controller/job_controller.dart';

import '../objects/Job.dart';

mixin JobService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // List<Job>? _jobFromQuerySnapshot(
  //     QuerySnapshot<Map<String, dynamic>> querySnapshot) {
  //   return querySnapshot.docs.map((doc) {
  //     if (doc.exists) {
  //       Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
  //       Job a = Job.fromJson(data, doc.id);
  //       JobController().add(a);
  //       return a;
  //     }
  //     return Job.dataTemplate();
  //   }).toList();
  // }

  List<Job>? _jobFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Job.fromDocumentSnapshot(documentSnapshot);
      }
      return Job();
    }).toList();
  }

  Stream<List<Job>?> get allJob {
    return _db.collection('quizzes').snapshots().map(_jobFromQuerySnapshot);
  }

  Future<List<Job>?> get allJobOnce {
    return _db.collection('quizzes').get().then(_jobFromQuerySnapshot);
  }

  Future<List<Job>?> getJobList() async {
    CollectionReference collection = _db.collection('quizzes');
    List<Job>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Job a = Job.fromJson(data, doc.id);
          return a;
        }
        return Job();
      }).toList();
    });
    return result;
  }
}
