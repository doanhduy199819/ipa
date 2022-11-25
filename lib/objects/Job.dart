import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Categories.dart';

class Job {
  String? id;
  String? name;
  List<Categories>? categories;

  Job({this.id, this.name, this.categories});

  factory Job.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String name = data?['jobs'];
    return Job(id: id, name: name);
  }

  factory Job.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Job.fromJson(documentSnapshot.data(), documentSnapshot.id);
  }

  factory Job.dataTemplate() {
    var id = '123';
    var name = 'IT';
    return Job(id: id, name: name);
  }

  static List<Job>? test() {}
}
