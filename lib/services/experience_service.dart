//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
// import 'package:flutter_interview_preparation/services/auth_service.dart';
//
// mixin ExperienceService{
//   FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   List<ExperiencePost>? _experienceFromQuerySnapshot(
//       QuerySnapshot<Map<String, dynamic>> querySnapshot) {
//     return querySnapshot.docs
//         .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
//       if (documentSnapshot.exists) {
//         return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
//       }
//       return ExperiencePost.test();
//     }).toList();
//   }
//
//   Stream<List<ExperiencePost>?> get allExperience {
//     return _db
//         .collection('experience')
//         .snapshots()
//         .map(_experienceFromQuerySnapshot);
//   }
//
//   Future<List<ExperiencePost>?> get allExperiencePostsOnce {
//     return _db.collection('experience').get().then(_experienceFromQuerySnapshot);
//   }
//
//   void addListExperiencePosts(List<ExperiencePost> list) {
//     list.forEach((experiencePost) => addExperiencePost(experiencePost));
//   }
//
//   void addExperiencePost(ExperiencePost experiencePost) async {
//     DocumentReference doc = _db.collection('experience').doc();
//     String doc_id = doc.id;
//     if (experiencePost.post_id == null) experiencePost.setPostId(doc_id);
//     String? user_id = AuthService().currentUserId;
//
//
//     // Add experiencePost comments to firebase
//     CollectionReference subcollection =
//     _db.collection('experience').doc(doc_id).collection('comments');
//     experiencePost.comments?.forEach((element) => subcollection.add(element.toJson()));
//
//     // Add experiencePost to firebase
//     doc
//         .set(experiencePost.toJson())
//         .then((value) => print('Experience added successfully'))
//         .catchError((error) => print('Failed to add an experiencePost'));
//   }
//
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
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
    return _db.collection('experience').orderBy('created_at',descending: true).get().then(_experienceFromQuerySnapshot);
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

  Stream<int> getNumberOfComment(String experiencePostId) {
    return _db
        .collection('experience')
        .doc(experiencePostId)
        .collection('comments')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  Stream<int> getLikeNumExperiencePost(String experiencePostId) {
    return _db
        .collection('experience')
        .doc(experiencePostId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      List<String>? liked_users_list= data?['liked_users'] is Iterable
          ? List.from(data?['liked_users'])
          : null;

      return (liked_users_list?.length ?? 0);
    });
  }

  // Stream<int> getLikeNumCommentInExperiencePost(String experiencePostId) {
  //   return _db
  //       .collection('experience')
  //       .doc(experiencePostId)
  //       .snapshots()
  //       .map((snapshot) {
  //     final data = snapshot.data();
  //     List<String>? liked_users_list= data?['liked_users'] is Iterable
  //         ? List.from(data?['liked_users'])
  //         : null;

  //     return (liked_users_list?.length ?? 0);
  //   });
  // }

  void likeExperiencePost(ExperiencePost experiencePost, bool active) {
    if (active) {
      _db.collection('experience').doc(experiencePost.post_id).update({
        "liked_users": FieldValue.arrayUnion([AuthService().currentUserId]),
      });
      print('like success');
    } else {
      _db.collection('experience').doc(experiencePost.post_id).update({
        "liked_users": FieldValue.arrayRemove([AuthService().currentUserId]),
      });
      print('Unlike success');
    }
  }

  void isAlreadyCommentInEachExperiencePost(ExperiencePost experiencePost,Comment comment, bool active){
    if(active){
      _db.collection('experience').doc(experiencePost.post_id).collection('comments').doc(comment.id).update(
          {
            "upvote_users":FieldValue.arrayUnion([AuthService().currentUser]),
          }
      );
      print('Liked This Comment');
    }
    else{
      _db.collection('experience').doc(experiencePost.post_id).collection('comments').doc(comment.id).update(
          {
            "upvote_users":FieldValue.arrayRemove([AuthService().currentUser]),
          }
      );
      print('Unliked This Comment');
    }
  }

  // Check if this user already like this post
  Future<bool> isAlreadyLikeExperiencePost(ExperiencePost experiencePost) async {
    if (AuthService().currentUserId == null) {
      throw Exception('No user');
    }
    bool res = false;
    String userId = AuthService().currentUserId!;
    await _db.collection('experience').doc(experiencePost.post_id).get().then((docSnap) {
      final data = docSnap.data();
      print('LikeUsers has data');
      List<String>? list =
      data?['liked_users'] is Iterable
          ? List.from(data?['liked_users'])
          : null;
      res = list?.contains(userId) ?? false;
    });
    return res;
  }



  Stream<int> likeState(ExperiencePost experiencePost) {
    String userId = AuthService().currentUserId!;
    return _db
        .collection('questions')
        .doc(experiencePost.post_id)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      List<String>? upVoteList = data?['liked_users'] is Iterable
          ? List.from(data?['liked_users'])
          : null;

      if (upVoteList?.contains(userId) ?? false) {
        return 1;
      }
      return 0;
    });
  }



}