import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/comment_box.dart';
import 'package:flutter_interview_preparation/pages/components/up_vote_stream_builder.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../../services/auth_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().commentsFromQuestion(widget.questionId),
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          debugPrint('rebuild qa_comments');
          return Helper().handleSnapshot(asyncSnapshot) ??
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
            decoration: InputDecoration(
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
            Spacer(),
            FlatButton(
              child: Text(
                'Send',
              ),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: _onSendButtonPressed,
            ),
          ],
        )
      ],
    );
  }

  void _onSendButtonPressed() {
    if (_formKey.currentState!.validate()) {
      // debugPrint('Sent comment button is pressed');
      _sendComment(commentContent);
      _clearCommentContent();

      // Move down to the end of screen
      ScrollController scrollControler =
          MyInheritedData.of(context).scrollController;
      // SchedulerBinding.instance.scheduleFrameCallback((_) {
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
            ?.map((comment) => commentBloc(
                  comment: comment,
                  questionId: widget.questionId,
                ))
            .toList()
      ],
    );
  }
}

class commentBloc extends StatelessWidget {
  const commentBloc({
    Key? key,
    required this.comment,
    required this.questionId,
  }) : super(key: key);

  final Comment comment;
  final String questionId;

  @override
  Widget build(BuildContext context) {
    CommentBoxWidget defaultCommentBox = CommentBoxWidget(
      userName: 'Author #${comment.author_id?.substring(0, 5)}',
      content: comment.content,
      voteNum: comment.vote,
    );

    return FutureBuilder(
        // Load author info
        future: DatabaseService().getFirestoreUser(comment.author_id ?? '0'),
        builder: (context, AsyncSnapshot<FirestoreUser?> userSnapshot) {
          return Helper().handleSnapshot(userSnapshot, defaultCommentBox) ??
              // Load comment voteNum
              StreamBuilder<int>(
                stream: DatabaseService()
                    .getCommentVoteNum(questionId, comment.id ?? '0'),
                builder: (context, voteNumSnapshot) {
                  debugPrint('rebuild base on stream votenum');
                  // Load current voteState
                  return Helper()
                          .handleSnapshot(voteNumSnapshot, defaultCommentBox) ??
                      FutureBuilder<int>(
                          future: _getDefaultUpDownVoteState(comment.id ?? '0'),
                          builder: (context, voteStateSnapshot) {
                            return Helper().handleSnapshot(
                                    voteStateSnapshot, defaultCommentBox) ??
                                CommentBoxWidget(
                                  photoUrl: userSnapshot.data?.photoUrl,
                                  userName: userSnapshot.data?.displayName,
                                  content: comment.content,
                                  voteNum: voteNumSnapshot.data,
                                  defaultVoteState: voteStateSnapshot.data,
                                  postFix: _buildMoreMethods(comment, context),
                                  upVoteHandle: _handleUpvote,
                                  downVoteHandle: _handleDownvote,
                                );
                          });
                },
              );
        });
  }

  Future<int> _getDefaultUpDownVoteState(String commentId) async {
    if (await DatabaseService().isUpvoteComment(questionId, commentId, true)) {
      return 1;
    } else if (await DatabaseService()
        .isUpvoteComment(questionId, commentId, false)) {
      return -1;
    }
    return 0;
  }

  DropdownButtonHideUnderline _buildMoreMethods(
      Comment comment, BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Visibility(visible: true, child: Icon(Icons.more_horiz_rounded)),
        items: [
          if (comment.author_id == AuthService().currentUserId) ...[
            DropdownMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          DropdownMenuItem(
            value: 'report',
            child: Text('Report'),
          ),
        ],
        onChanged: ((value) {
          if (value == 'report') {
          } else if (value == 'edit') {
          } else if (value == 'delete') {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Delete?'),
                      content:
                          Text('Are you sure want to delete this comment?'),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              _dissmissAlertDialog(context);
                            },
                            child: Text('No')),
                        FlatButton(
                            onPressed: () {
                              _dissmissAlertDialog(context);
                              debugPrint('Comfirm delete comment');
                              DatabaseService().deleteCommentFromQuestion(
                                  comment.id!, questionId);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.red),
                            )),
                      ],
                    ),
                barrierDismissible: true);
          }
        }),
      ),
    );
  }

  void _dissmissAlertDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  void _handleUpvote(bool isUpvote) {
    debugPrint('qa comments call');
    DatabaseService().upVoteComment(questionId, comment.id!, !isUpvote);
    if (!isUpvote)
      DatabaseService().downVoteComment(questionId, comment.id ?? '0', false);
  }

  void _handleDownvote(bool isDownvote) {
    debugPrint('qa comments call');
    DatabaseService().downVoteComment(questionId, comment.id!, !isDownvote);
    if (!isDownvote)
      DatabaseService().upVoteComment(questionId, comment.id ?? '0', false);
  }
}
