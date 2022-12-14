// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/comment/comment_box.dart';
import 'package:flutter_interview_preparation/pages/components/inherited/my_inherited_data.dart';
import 'package:flutter_interview_preparation/pages/components/up_vote_stream_builder.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/more-options_button.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../../objects/UserBlocked.dart';
import '../../../../services/auth_service.dart';

//
// class QAComments extends StatefulWidget {
//   String questionId;
//
//   QAComments({Key? key, required this.questionId}) : super(key: key);
//
//   @override
//   State<QAComments> createState() => _QACommentsState();
// }
//
// class _QACommentsState extends State<QAComments> {
//   String commentContent = "";
//   late List<Comment>? comments;
//   final _formKey = GlobalKey<FormState>();
//   final _textFieldController = TextEditingController();
//   final _commentFocusNode = FocusNode();
//   late Stream<List<Comment>?> _commentsStream;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _commentsStream = DatabaseService().commentsFromQuestion(widget.questionId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: _commentsStream,
//         builder: (BuildContext context,
//             AsyncSnapshot<List<Comment>?> asyncSnapshot) {
//           debugPrint(
//               'rebuild qa_comments\n--------------------------------------\n');
//           return Helper.handleSnapshot(asyncSnapshot) ??
//               Column(
//                 children: [
//                   commentInput(),
//                   Divider(),
//                   commentsList(asyncSnapshot.data),
//                 ],
//               );
//         });
//   }
//
//   // Where user input their comment
//   Widget commentInput() {
//     return Column(
//       children: [
//         Form(
//           key: _formKey,
//           child: TextFormField(
//             controller: _textFieldController,
//             focusNode: _commentFocusNode,
//             keyboardType: TextInputType.multiline,
//             maxLines: null,
//             minLines: 1,
//             decoration: const InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Comment here!',
//             ),
//             validator: (value) {
//               if (value == null || value.length < 1) {
//                 return 'Nothing to comment';
//               }
//             },
//             onChanged: (value) => commentContent = value,
//             autofocus: false,
//             scrollPadding: EdgeInsets.only(bottom: 8 + 64),
//           ),
//         ),
//         Row(
//           children: [
//             Spacer(),
//             FlatButton(
//               color: Colors.blueAccent,
//               textColor: Colors.white,
//               onPressed: _onSendButtonPressed,
//               child: const Text(
//                 'Send',
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
//
//   void _onSendButtonPressed() {
//     if (_formKey.currentState!.validate()) {
//       _sendComment(commentContent);
//       _clearCommentContent();
//
//       // Move down to the end of screen
//       ScrollController scrollControler =
//           MyInheritedData.of(context).scrollController;
//       SchedulerBinding.instance.addPostFrameCallback((_) {
//         scrollControler.animateTo(
//           scrollControler.position.maxScrollExtent,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.fastOutSlowIn,
//         );
//       });
//     }
//   }
//
//   Widget headingComment(int numberOfComments) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.centerLeft,
//         children: [
//           const Text(
//             'Comments',
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//           ),
//           Positioned(
//             top: -4,
//             right: -24,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 4.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Text(numberOfComments.toString(),
//                   style: TextStyle(color: Colors.white, fontSize: 12)),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   // Send user input to server
//   void _sendComment(String content) async {
//     await DatabaseService().addCommentToQuestion(content, widget.questionId);
//   }
//
//   // Clear commentInput
//   void _clearCommentContent() {
//     _textFieldController.clear();
//   }
//
//   // List of comments of this question
//   Widget commentsList(List<Comment>? comments) {
//     return Column(
//       children: <Widget>[
//         ...?comments
//             ?.map((comment) => LoadUserInfoCommentBox(
//                   comment: comment,
//                   questionId: widget.questionId,
//                 ))
//             .toList()
//       ],
//     );
//   }
// }
//
// class LoadUserInfoCommentBox extends StatefulWidget {
//   const LoadUserInfoCommentBox(
//       {Key? key, required this.comment, required this.questionId})
//       : super(key: key);
//
//   final Comment comment;
//   final String questionId;
//
//   @override
//   State<LoadUserInfoCommentBox> createState() => LoadUserCommentBoxStateBox();
// }
//
// class LoadUserCommentBoxStateBox extends State<LoadUserInfoCommentBox> {
//   late Future<FirestoreUser?> _future;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _future = DatabaseService().getFirestoreUser(widget.comment.author_id!);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<FirestoreUser?>(
//       future: _future,
//       builder: (context, userInfoSnapshot) {
//         return Helper.handleSnapshot(userInfoSnapshot) ??
//             CommentBoxWidget(
//               photoUrl: userInfoSnapshot.data?.photoUrl,
//               userName: userInfoSnapshot.data?.displayName,
//               content: widget.comment.content,
//               voteNum: widget.comment.vote,
//               defaultVoteState: voteState,
//               postFix: MoreOptionsDropDownButton(
//                 comment: widget.comment,
//                 onDelete: () => DatabaseService().deleteCommentFromQuestion(
//                     widget.comment.id!, widget.questionId),
//                 idQuestion: widget.questionId,
//               ),
//               upVoteHandle: _handleUpvote,
//               downVoteHandle: _handleDownvote,
//               timeString:
//                   Helper.toFriendlyDurationTime(widget.comment.created_at),
//             );
//       },
//     );
//   }
//
//   int get voteState {
//     if (widget.comment.upvote_users
//             ?.contains(AuthService().currentUserId ?? '') ??
//         false) {
//       return 1;
//     } else if (widget.comment.downvote_users
//             ?.contains(AuthService().currentUserId ?? '') ??
//         false) {
//       return -1;
//     }
//     return 0;
//   }
//
//   void _handleUpvote(bool isUpvote) {
//     DatabaseService()
//         .upVoteComment(widget.questionId, widget.comment.id!, !isUpvote);
//     if (!isUpvote)
//       DatabaseService()
//           .downVoteComment(widget.questionId, widget.comment.id!, false);
//   }
//
//   void _handleDownvote(bool isDownvote) {
//     DatabaseService()
//         .downVoteComment(widget.questionId, widget.comment.id!, !isDownvote);
//     if (!isDownvote)
//       DatabaseService()
//           .upVoteComment(widget.questionId, widget.comment.id!, false);
//   }
// }
class QAComments extends StatefulWidget {
  String questionId;

  QAComments({Key? key, required this.questionId}) : super(key: key);

  @override
  State<QAComments> createState() => _QACommentsState();
}

class _QACommentsState extends State<QAComments> {
  String commentContent = "";
  late List<Comment>? comments;
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  final _commentFocusNode = FocusNode();
  late Stream<List<Comment>?> _commentsStream;
  late Future<List<UserBlocked>?> _userBlockedFuture;

  @override
  void initState() {
    // TODO: implement initState
    _commentsStream = DatabaseService().commentsFromQuestion(widget.questionId);
     FirebaseFirestore _db = FirebaseFirestore.instance;

    _userBlockedFuture = _db
        .collection('userwasblocked')
        .get()
        .then(_userBlockedsFromQuerySnapshot);
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _commentsStream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          debugPrint(
              'rebuild qa_comments\n--------------------------------------\n');
          return Helper.handleSnapshot(asyncSnapshot) ??
              Column(
                children: [
                  commentInput(),
                  Divider(),
                  commentsList(asyncSnapshot.data),
                ],
              );
        });
  }

  // Where user input their comment
  Widget commentInput() {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: _textFieldController,
            focusNode: _commentFocusNode,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            minLines: 1,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Comment here!',
            ),
            validator: (value) {
              if (value == null || value.length < 1) {
                return 'Nothing to comment';
              }
            },
            onChanged: (value) => commentContent = value,
            autofocus: false,
            scrollPadding: EdgeInsets.only(bottom: 8 + 64),
          ),
        ),
        Row(
          children: [
            const Spacer(),
            FlatButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: _onSendButtonPressed,
              child: const Text(
                'Send',
              ),
            ),
          ],
        )
      ],
    );
  }

  void _onSendButtonPressed() async {
    var usersblocked = await _userBlockedFuture;
    for (int i = 0; i < usersblocked!.length; i++) {
      if (usersblocked[i].id_user == AuthService().currentUser!.uid) {
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
    if (_formKey.currentState!.validate()) {
      _sendComment(commentContent);
      _clearCommentContent();

      // Move down to the end of screen
      ScrollController scrollControler =
          MyInheritedData.of(context).scrollController;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollControler.animateTo(
          scrollControler.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  Widget headingComment(int numberOfComments) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Comments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
          Positioned(
            top: -4,
            right: -24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(numberOfComments.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }

  // Send user input to server
  void _sendComment(String content) async {
    await DatabaseService().addCommentToQuestion(content, widget.questionId);
  }

  // Clear commentInput
  void _clearCommentContent() {
    _textFieldController.clear();
  }

  // List of comments of this question
  Widget commentsList(List<Comment>? comments) {
    return Column(
      children: <Widget>[
        ...?comments
            ?.map((comment) => LoadUserInfoCommentBox(
                  comment: comment,
                  questionId: widget.questionId,
                ))
            .toList()
      ],
    );
  }
}

class LoadUserInfoCommentBox extends StatefulWidget {
  const LoadUserInfoCommentBox(
      {Key? key, required this.comment, required this.questionId})
      : super(key: key);

  final Comment comment;
  final String questionId;

  @override
  State<LoadUserInfoCommentBox> createState() => LoadUserCommentBoxStateBox();
}

class LoadUserCommentBoxStateBox extends State<LoadUserInfoCommentBox> {
  late Future<FirestoreUser?> _future;

  @override
  void initState() {
    // TODO: implement initState
    _future = DatabaseService().getFirestoreUser(widget.comment.author_id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirestoreUser?>(
      future: _future,
      builder: (context, userInfoSnapshot) {
        return Helper.handleSnapshot(userInfoSnapshot) ??
            CommentBoxWidget(
              photoUrl: userInfoSnapshot.data?.photoUrl,
              userName: userInfoSnapshot.data?.displayName,
              content: widget.comment.content,
              voteNum: widget.comment.vote,
              defaultVoteState: voteState,
              postFix: MoreOptionsDropDownButton(
                comment: widget.comment,
                onDelete: () => DatabaseService().deleteCommentFromQuestion(
                    widget.comment.id!, widget.questionId),
                idQuestion: widget.questionId,
                screen: 'questions',
              ),
              upVoteHandle: _handleUpvote,
              downVoteHandle: _handleDownvote,
              timeString:
                  Helper.toFriendlyDurationTime(widget.comment.created_at),
            );
      },
    );
  }

  int get voteState {
    if (widget.comment.upvote_users
            ?.contains(AuthService().currentUserId ?? '') ??
        false) {
      return 1;
    } else if (widget.comment.downvote_users
            ?.contains(AuthService().currentUserId ?? '') ??
        false) {
      return -1;
    }
    return 0;
  }

  void _handleUpvote(bool isUpvote) {
    DatabaseService()
        .upVoteComment(widget.questionId, widget.comment.id!, !isUpvote);
    if (!isUpvote)
      DatabaseService()
          .downVoteComment(widget.questionId, widget.comment.id!, false);
  }

  void _handleDownvote(bool isDownvote) {
    DatabaseService()
        .downVoteComment(widget.questionId, widget.comment.id!, !isDownvote);
    if (!isDownvote)
      DatabaseService()
          .upVoteComment(widget.questionId, widget.comment.id!, false);
  }
}
