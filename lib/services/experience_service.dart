
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

mixin ExperienceService{
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
  }

  Stream<List<ExperiencePost>?> get allExperience {
    return _db
        .collection('experience')
        .snapshots()
        .map(_experienceFromQuerySnapshot);
  }

  Future<List<ExperiencePost>?> get allExperiencePostsOnce {
    return _db.collection('experience').get().then(_experienceFromQuerySnapshot);
  }

  void addListExperiencePosts(List<ExperiencePost> list) {
    list.forEach((experiencePost) => addExperiencePost(experiencePost));
  }

  void addExperiencePost(ExperiencePost experiencePost) async {
    DocumentReference doc = _db.collection('experience').doc();
    String doc_id = doc.id;
    if (experiencePost.post_id == null) experiencePost.setPostId(doc_id);
    String? user_id = AuthService().currentUserId;


    // Add experiencePost comments to firebase
    CollectionReference subcollection =
    _db.collection('experience').doc(doc_id).collection('comments');
    experiencePost.comments?.forEach((element) => subcollection.add(element.toJson()));

    // Add experiencePost to firebase
    doc
        .set(experiencePost.toJson())
        .then((value) => print('Experience added successfully'))
        .catchError((error) => print('Failed to add an experiencePost'));
  }

}