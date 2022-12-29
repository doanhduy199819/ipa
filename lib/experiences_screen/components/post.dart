// import 'package:flutter/material.dart';
// import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
// import 'package:intl/intl.dart';
//
// import '../screens/detail_post_screen.dart';
// import '../screens/experiences_home_screen.dart';
// class Posts extends StatefulWidget {
//   final List<ExperiencePost>? post;
//   Posts({required this.post});
//   @override
//   _PostsState createState() => _PostsState();
// }
//
// class _PostsState extends State<Posts> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: widget.post!
//             .map(
//               (eachPost) => GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => PostScreen(experiencePost: eachPost)));
//             },
//             child: Container(
//               height: 180,
//               margin: const EdgeInsets.all(12.0),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black26.withOpacity(0.1),
//                         blurRadius: 8.0,
//                         offset: const Offset(5, -5.0),
//                         spreadRadius: 0.10),
//                   ]),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       height: 70,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               const CircleAvatar(
//                                 backgroundImage: AssetImage(
//                                     'assets/images/avatar.png'),
//                                 radius: 22,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       width: MediaQuery.of(context)
//                                           .size
//                                           .width *
//                                           0.65,
//                                       child: Text(
//                                         (eachPost.title?.length ?? 0) > 40 ? "${eachPost.title?.substring(0, 40)}...":"${eachPost.title}" ,
//                                         style: const TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: .4),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2.0),
//                                     Row(
//                                       children: <Widget>[
//                                         Text(
//                                           'Admin',
//                                           style: TextStyle(
//                                               color: Colors.grey
//                                                   .withOpacity(0.6)),
//                                         ),
//                                         const SizedBox(width: 16),
//                                         Text(
//                                           parseDateTime(eachPost.created_at),
//                                           style: TextStyle(
//                                               color: Colors.grey
//                                                   .withOpacity(0.6)),
//                                         )
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       child: Center(
//                         child: Text(
//                           (eachPost.content?.length ?? 0) > 80 ? "${eachPost.content?.substring(0, 80)}..":"${eachPost.content}" ,
//                           style: TextStyle(
//                               color: Colors.grey.withOpacity(0.8),
//                               fontSize: 16,
//                               letterSpacing: .3),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Icon(
//                               Icons.favorite,
//                               color: Colors.grey.withOpacity(0.6),
//                               size: 22,
//                             ),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               "${eachPost.liked_users?.length ?? 0} likes",
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.withOpacity(0.6),
//                                   fontWeight: FontWeight.w600),
//                             )
//                           ],
//                         ),
//                         Row(
//                           children: <Widget>[
//                             Icon(
//                               Icons.comment,
//                               color: Colors.grey.withOpacity(0.6),
//                               size: 16,
//                             ),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               "${eachPost.comments?.length ?? 0} comment",
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.withOpacity(0.6)),
//                             )
//                           ],
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         )
//             .toList());
//   }
//
//   String parseDateTime(DateTime? date) {
//     DateFormat formatter = DateFormat('dd/MM/yyyy');
//     String created_at;
//     if (date != null) {
//       created_at = formatter.format(date);
//     } else {
//       created_at = '01/01/2001';
//     }
//     return created_at;
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/interactive_bloc.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/interactive_stream_builder.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
import 'package:intl/intl.dart';

import '../../objects/UserBlocked.dart';
import '../../services/auth_service.dart';
import '../screens/detail_post_screen.dart';
import '../screens/experiences_home_screen.dart';

class Posts extends StatefulWidget {
  final List<ExperiencePost>? post;
  Posts({required this.post});
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late Future<List<UserBlocked>?> _userBlockedFuture;
  var defaultInteractiveBloc =
  InteractiveBloc(numberOfComments: 0, numberOfLikes: 0);

  List<UserBlocked>? _userBlockedsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        print('exits');
        return UserBlocked.fromDocumentSnapshot(documentSnapshot);
      }
      return UserBlocked.test();
    }).toList();
  }

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;

    _userBlockedFuture = _db
        .collection('userwasblocked')
        .get()
        .then(_userBlockedsFromQuerySnapshot);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ExperiencePost>? postUserCanSee =
    widget.post!.where((p) => p.isApproved == true).toList();
    return Column(
        children: postUserCanSee
            .map(
              (eachPost) => GestureDetector(
            onTap: () async {
              print(eachPost.toString());
              var usersblocked = await _userBlockedFuture;
              try {
                for (int i = 0; i < usersblocked!.length; i++) {
                  if (usersblocked[i].id_user ==
                      AuthService().currentUser!.uid) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            scrollable: true,
                            title: const Text('Ban'),
                            content: const Center(
                              child: Text('User was banned'),
                            ),
                            actions: [
                              TextButton(
                                child: const Text("Return"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        });
                    return;
                  }
                }
              } catch (error) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: const Text('Error'),
                        content: Center(
                          child: Text('${error.toString()}'),
                        ),
                        actions: [
                          TextButton(
                            child: Text("Return"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    });
              }
              ;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          PostScreen(experiencePost: eachPost)));
            },
            child: Container(
              height: 180,
              margin: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(5, -5.0),
                        spreadRadius: 0.10),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              const CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                                radius: 22,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.65,
                                      child: Text(
                                          (eachPost.title?.length ?? 0) > 40 ? "${eachPost.title?.substring(0, 40)}...":"${eachPost.title}"  ?? 'Title is null',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .4),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          eachPost.author_name??'Admin',
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.6)),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          parseDateTime(
                                              eachPost.created_at),
                                          style: TextStyle(
                                              color: Colors.grey
                                                  .withOpacity(0.6)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Center(
                        child: Text(
                          (eachPost.content?.length ?? 0) > 80
                              ? "${eachPost.content?.substring(0, 80)}.."
                              : "${eachPost.content}",
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.8),
                              fontSize: 16,
                              letterSpacing: .3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    InteractiveStreamBuilder(
                        experiencePost: eachPost,
                        defaultInteractiveBloc: defaultInteractiveBloc,
                        child: (numberOfLikes, numberOfComments) =>
                            InteractiveBloc(
                              numberOfLikes: numberOfLikes,
                              numberOfComments: numberOfComments,
                            )),

                  ],
                ),
              ),
            ),
          ),
        )
            .toList());
  }

  String parseDateTime(DateTime? date) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String created_at;
    if (date != null) {
      created_at = formatter.format(date);
    } else {
      created_at = '01/01/2001';
    }
    return created_at;
  }
}