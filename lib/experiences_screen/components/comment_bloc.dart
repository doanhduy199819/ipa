import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/interactive_like_comment_stream.dart';
import 'package:flutter_interview_preparation/experiences_screen/components/like_comment.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import '../../../objects/Comment.dart';
import '../../../services/auth_service.dart';
import '../../../objects/Helper.dart';
import '../../../services/database_service.dart';
import 'package:intl/intl.dart';

import '../../pages/home_screen/questions_answers/components/more-options_button.dart';
import 'like_handle.dart';
class CommentExperiencePostBloc extends StatefulWidget {
  ExperiencePost? experiencePost;

  CommentExperiencePostBloc({Key? key, required this.experiencePost})
      : super(key: key);

  @override
  State<CommentExperiencePostBloc> createState() =>
      _CommentExperiencePostBlocState();
}

class _CommentExperiencePostBlocState extends State<CommentExperiencePostBloc> {
  late Stream<List<Comment>?> _stream;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _stream = DatabaseService()
        .commentsFromExperiencePost(widget.experiencePost?.post_id ?? 'Error');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          List<Comment>? comments = asyncSnapshot.data;
          return Helper.handleSnapshot(asyncSnapshot) ??
              Column(
                children: [
                  _buildCommentsList(
                    comments: comments,
                    experiencePost:
                    widget.experiencePost ?? ExperiencePost.test(),
                  ),
                ],
              );
        });
  }
}

class _buildCommentsList extends StatefulWidget {
  const _buildCommentsList({
    Key? key,
    required this.comments,
    // required this.experiencePostId,
    required this.experiencePost,
  }) : super(key: key);

  final List<Comment>? comments;
  //final String experiencePostId;
  final ExperiencePost experiencePost;

  @override
  State<_buildCommentsList> createState() => _buildCommentsListState();
}

class _buildCommentsListState extends State<_buildCommentsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...(widget.comments!
            .map(
              (reply) => Container(
            margin:
            const EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26.withOpacity(0.2),
                    offset: const Offset(0.0, 4.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.10)
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 60,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        UserInfoCommentBox(
                          comment: reply,
                          experiencePostId:
                          widget.experiencePost.post_id ?? 'NONAME',
                        ),
                        Expanded(
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: MoreOptionsDropDownButton(
                                comment: reply,
                                idQuestion: widget.experiencePost.post_id ??
                                    'Error',
                                onDelete: () => DatabaseService()
                                    .deleteCommentFromExperiencePost(
                                    reply.id ?? 'Error',
                                    widget.experiencePost.post_id ??
                                        'Error'),
                                screen: 'experience',
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      reply.content ?? 'content is null',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.25),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Icon(
                      //   Icons.favorite,
                      //   color: Colors.grey.withOpacity(0.5),
                      //   size: 20,
                      // ),
                      FutureBuilder<int>(
                        future: _getDefaultLikeState(reply),
                        builder: (context, snapshot) {
                          return Helper.handleSnapshot(snapshot) ??
                              LikeComment(
                                experiencePostId:
                                widget.experiencePost.post_id,
                                isHorizontal: true,
                                likeHandle: _handleLike,
                                commentId: reply.id,
                                defaultVoteState: snapshot.data ?? 0,
                              );
                        },
                      ),

                      const SizedBox(width: 4.0),
                      // NumberLikesExperiencePost(
                      //         experiencePost: widget.experiencePost),
                      InteractiveLikeStreamBuilder(
                          experiencePost: widget.experiencePost,
                          comment: reply),
                      // Text(
                      //   "${(reply.upvote_users?.length ?? 0) - (reply.downvote_users?.length ?? 0)}",
                      //   style:
                      //       TextStyle(color: Colors.grey.withOpacity(0.5)),
                      // )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
            .toList()),
      ],
    );
  }

  Future<int> _getDefaultLikeState(Comment comment) async {
    if (await DatabaseService().isLikedCommentInExperiencePost(
        widget.experiencePost.post_id ?? '0', comment.id ?? '0')) {
      return 1;
    }
    return 0;
  }

  void _handleLike(bool isLike, String commentId) {
    DatabaseService().likeCommentInExperiencePost(
        widget.experiencePost.post_id ?? '0', commentId, !isLike);
  }
}

class UserInfoCommentBox extends StatefulWidget {
  UserInfoCommentBox(
      {Key? key, required this.comment, required this.experiencePostId})
      : super(key: key);

  final Comment comment;
  final String experiencePostId;
  // late var isAnonymous;
  // late var user;

  @override
  State<UserInfoCommentBox> createState() => UserCommentBoxStateBox();
}

class UserCommentBoxStateBox extends State<UserInfoCommentBox> {
  late Future<FirestoreUser?> _future;
  late Future<bool?> _futureAnonymous;
  late User? user;

  @override
  void initState() {
    // TODO: implement initState

    // lay User = .comment.author_id
    _future = DatabaseService().getFirestoreUser(widget.comment.author_id!);

    //Xac dinh xem user co phai user moi k
    _futureAnonymous = DatabaseService().isNewUser(AuthService().currentUser);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.comment.created_at);
    return FutureBuilder<FirestoreUser?>(
      future: _future,
      builder: (context, userInfoSnapshot) {
        return Helper.handleSnapshot(userInfoSnapshot) ??
            FutureBuilder(
              future: _futureAnonymous,
              builder: (context, snapshot) {
                print(' UID USer: ${userInfoSnapshot.data?.uid}');
                print('Full infor:${userInfoSnapshot.data}');
                print('IS NEW ACCOUNT: ${snapshot}');
                return Helper.handleSnapshot(snapshot) ??
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // TK khong co UID thi de la noname
                          (userInfoSnapshot.data?.uid == null)
                              ? const Text('NONAME')
                              : Text(
                              userInfoSnapshot.data?.displayName ?? 'Null'),
                          const SizedBox(height: 2.0),
                          Text(
                            Helper.toFriendlyDurationTime(
                                widget.comment.created_at),
                            style:
                            TextStyle(color: Colors.grey.withOpacity(0.4)),
                          )
                        ],
                      ),
                    );
              },
            );
      },
    );
  }
}
