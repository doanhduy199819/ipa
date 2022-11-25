import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories {
  String? id;
  String? name;
  Categories({this.id, this.name});

  factory Categories.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    // print("id: ${id}");
    final String name = data?['name'];
    // print("name: ${name}");
    return Categories(id: id, name: name);
  }

  factory Categories.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Categories.fromJson(documentSnapshot.data(), documentSnapshot.id);
  }
}
