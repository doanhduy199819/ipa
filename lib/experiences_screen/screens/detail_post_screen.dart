// import 'package:flutter/material.dart';
// import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
// import 'package:intl/intl.dart';
//
//
// class PostScreen extends StatefulWidget {
//   @override
//   final ExperiencePost? experiencePost;
//   PostScreen({this.experiencePost});
//   _PostScreenState createState() => _PostScreenState();
// }
//
// class _PostScreenState extends State<PostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: ListView(
//           children: <Widget>[
//             Container(
//               padding:
//               const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
//               child: Row(
//                 children: <Widget>[
//                   IconButton(
//                       onPressed: () => Navigator.pop(context),
//                       icon: const Icon(
//                         Icons.arrow_left,
//                         size: 20,
//                         color: Colors.black,
//                       )),
//                   const SizedBox(width: 4.0),
//                   const Text(
//                     "View Post",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black26.withOpacity(0.2),
//                         offset: const Offset(1, -4.0),
//                         blurRadius: 10.0,
//                         spreadRadius: 0.10)
//                   ]),
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 60,
//                       color: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Row(
//                             children: <Widget>[
//                               const CircleAvatar(
//                                 backgroundImage:
//                                 AssetImage('assets/images/avatar.png'),
//                                 radius: 22,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       child: const Text(
//                                         'Admin',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             letterSpacing: .4),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 2.0),
//                                     Text(
//                                       parseDateTime(
//                                           widget.experiencePost?.created_at),
//                                       style:
//                                       const TextStyle(color: Colors.grey),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       child: Text(
//                         widget.experiencePost?.title ??
//                             'experiencePost is null',
//                         style: TextStyle(
//                           fontSize: 24,
//                           color: Colors.black.withOpacity(0.8),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       widget.experiencePost!.content ?? 'content is null',
//                       style: TextStyle(
//                           color: Colors.black.withOpacity(0.4),
//                           fontSize: 17,
//                           letterSpacing: .2),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               IconButton(onPressed: (){}, icon: Icon(
//                                 Icons.favorite,
//                                 color: Colors.grey.withOpacity(0.5),
//                                 size: 22,
//                               ),),
//
//                               SizedBox(width: 4.0),
//                               Text(
//                                 "${widget.experiencePost?.liked_users?.length ?? '0'} like",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey.withOpacity(0.5),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//               const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
//               child: Text(
//                 "Replies (${widget.experiencePost?.comments?.length ?? '0'})",
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//
//             //Comments
//             (widget.experiencePost != null)
//                 ? (widget.experiencePost!.comments != null)
//                 ? Column(
//               children: widget.experiencePost!.comments!
//                   .map((reply) => Container(
//                   margin: const EdgeInsets.only(
//                       left: 12.0, right: 12.0, top: 20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(10.0),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black26.withOpacity(0.2),
//                           offset: const Offset(0.0, 4.0),
//                           blurRadius: 10.0,
//                           spreadRadius: 0.10)
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           height: 60,
//                           color: Colors.white,
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Row(
//                                 children: <Widget>[
//                                   const CircleAvatar(
//                                     backgroundImage:
//                                     AssetImage('author1.jpg'),
//                                     radius: 18,
//                                   ),
//                                   Padding(
//                                     padding:
//                                     const EdgeInsets.only(
//                                         left: 8.0),
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment
//                                           .start,
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .center,
//                                       children: <Widget>[
//                                         Container(
//                                           child: const Text(
//                                             'Admin',
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight:
//                                                 FontWeight
//                                                     .w600,
//                                                 letterSpacing:
//                                                 .4),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                             height: 2.0),
//                                         Text(
//                                           widget.experiencePost
//                                               ?.created_at
//                                               .toString() ??
//                                               '01/01/2001',
//                                           style: TextStyle(
//                                               color: Colors.grey
//                                                   .withOpacity(
//                                                   0.4)),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15.0),
//                           child: Text(
//                             reply.content ?? 'content is null',
//                             style: TextStyle(
//                               color:
//                               Colors.black.withOpacity(0.25),
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.start,
//                           children: <Widget>[
//                             Icon(
//                               Icons.favorite,
//                               color: Colors.grey.withOpacity(0.5),
//                               size: 20,
//                             ),
//                             const SizedBox(width: 4.0),
//                             Text(
//                               "${(reply.upvote_users?.length ?? 0) - (reply.downvote_users?.length ?? 0)}",
//                               style: TextStyle(
//                                   color: Colors.grey
//                                       .withOpacity(0.5)),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   )))
//                   .toList(),
//             )
//                 : Container()
//                 : const Center(
//               child: Text('Something went wrong'),
//             )
//           ],
//         ),
//       ),
//     );
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


import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/comment_bloc.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/like_handle.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/number_comments.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/number_likes.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
import 'package:flutter_interview_preparation/pages/components/comment/comment_input.dart';
import 'package:flutter_interview_preparation/services/account_service.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';

import '../../../objects/FirestoreUser.dart';
import '../../../objects/Helper.dart';

class PostScreen extends StatefulWidget {
  @override
  final ExperiencePost? experiencePost;
  PostScreen({this.experiencePost});
  late var isAnonymous;
  late var user;
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    widget.user = AuthService().currentUser;
    widget.isAnonymous = DatabaseService().isNewUser(widget.user);
    print('User: ${widget.user}');
    print('Anonymous: ${widget.isAnonymous}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.experiencePost?.post_id ?? 'null');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_left,
                        size: 20,
                        color: Colors.black,
                      )),
                  const SizedBox(width: 4.0),
                  const Text(
                    "View Post",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.2),
                        offset: const Offset(1, -4.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 60,
                      color: Colors.white,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: const Text(
                                        'Admin',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: .4),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Text(
                                      parseDateTime(
                                          widget.experiencePost?.created_at),
                                      style:
                                      const TextStyle(color: Colors.grey),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        widget.experiencePost?.title ??
                            'experiencePost is null',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.experiencePost!.content ?? 'content is null',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.4),
                          fontSize: 17,
                          letterSpacing: .2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FutureBuilder<int>(
                                future: _getDefaultLikeState(),
                                builder: (context, snapshot) {
                                  return Helper.handleSnapshot(snapshot) ??
                                      LikePost(
                                        isHorizontal: true,
                                        likeHandle: _handleLike,
                                        defaultVoteState: snapshot.data ?? 0,
                                      );
                                },
                              ),
                              // IconButton(
                              //   onPressed: () {

                              //   },
                              //   icon: Icon(
                              //     Icons.favorite,
                              //     color: Colors.grey.withOpacity(0.5),
                              //     size: 22,
                              //   ),
                              // ),

                              const SizedBox(width: 4.0),
                              // Text(
                              //   "${widget.experiencePost?.liked_users?.length ?? '0'} like",
                              //   style: TextStyle(
                              //     fontSize: 14,
                              //     color: Colors.grey.withOpacity(0.5),
                              //   ),
                              // )
                              NumberLikesExperiencePost(
                                  experiencePost: widget.experiencePost),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            NumberCommentsOfPost(experiencePost: widget.experiencePost),

            //Comments

            (widget.user.isAnonymous == false)
                ? CommentInput(
                onSendButtonPressed: (content) => DatabaseService()
                    .addCommentToExperiencePost(
                    content, widget.experiencePost?.post_id ?? 'error'))
                : Center(child: const Text('Login to Comment')),
            CommentExperiencePostBloc(experiencePost: widget.experiencePost)
          ],
        ),
      ),
    );
  }

  Future<int> _getDefaultLikeState() async {
    if (await DatabaseService().isAlreadyLikeExperiencePost(
        widget.experiencePost ?? ExperiencePost.test())) {
      return 1;
    }
    return 0;
  }

  void _handleLike(bool isLike) {
    DatabaseService().likeExperiencePost(
        widget.experiencePost ?? ExperiencePost.test(), !isLike);
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
