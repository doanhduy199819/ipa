import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/CommentReport.dart';

import 'auth_service.dart';

mixin CommentReportService{

  FirebaseFirestore _db = FirebaseFirestore.instance;

  void addCommentReport(CommentReport commentReport) async {
    DocumentReference doc = _db.collection('reportcomment').doc();
    String doc_id = doc.id;
    if (commentReport.id_report_comment == null) commentReport.setIdReportComment(doc_id);
    String? user_id = AuthService().currentUserId;
    commentReport.setIdAccuser(user_id??'Error');
    // Add comment report to firebase
    doc
        .set(commentReport.toJson())
        .then((value) => print('report added successfully'))
        .catchError((error) => print('Failed to add a report'));
  }
}