// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/pages/components/comment_box.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../objects/FirestoreUser.dart';
import '../../../objects/ArticlePost.dart';
import '../../../objects/Comment.dart';

class ArticleCommentPart extends StatefulWidget {
  String articleId;
  ArticleCommentPart({Key? key, required this.articleId}) : super(key: key);

  @override
  State<ArticleCommentPart> createState() => _ArticleCommentPartState();
}

class _ArticleCommentPartState extends State<ArticleCommentPart> {
  late List<Comment>? comments;
  late FirestoreUser account;
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  String commentContent = "";
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();
  final _commentFocusNode = FocusNode();
  // bool isSendButtonDisabled = true;

  @override
  void initState() {
    // account = new Account(
    //     'https://images.pexels.com/photos/5245865/pexels-photo-5245865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     'Nhat Tan',
    //     2871,
    //     100,
    //     100,
    //     100);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().commentsFromArticle(widget.articleId),
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Text('Something went wrong :(');
          }
          if (asyncSnapshot.data == null ||
              asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                CircularProgressIndicator(),
              ],
            );
          }
          comments = asyncSnapshot.data;
          return Column(
            children: [
              headingComment(),
              SizedBox(
                height: 10,
              ),
              commentInput(comments),
              Divider(),
              commentsList(comments),
            ],
          );
        });
  }

  // Where user input their comment
  Container commentInput(List<Comment>? comments) {
    print('hechhc');
    return Container(
      child: Column(
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
      ),
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

  Widget headingComment() {
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
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(comments?.length.toString() ?? '0',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            top: -4,
            right: -24,
          )
        ],
      ),
    );
  }

  // Send user input to server
  void _sendComment(String content) async {
    await DatabaseService().addCommentToArticle(content, widget.articleId);
  }

  // Clear commentInput
  void _clearCommentContent() {
    _textFieldController.clear();
  }

  // List of comments of this article
  Widget commentsList(List<Comment>? comments) {
    return Column(
      children: <Widget>[
        ...?comments?.map((comment) => commentBloc(comment)).toList()
      ],
    );
  }

  // Each comment in commentsList
  Widget commentBloc(Comment comment) {
    return CommentBoxWidget(
      photoUrl: account.avatar,
      userName: account.name,
      isShowingUpvote: false,
      content: comment.content,
      postFix: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon:
              Visibility(visible: true, child: Icon(Icons.more_horiz_rounded)),
          items: [
            if (comment.author_id == AuthService().currentUserId) ...[
              DropdownMenuItem(
                child: Text('Delete'),
                value: 'delete',
              ),
            ],
            DropdownMenuItem(
              child: Text('Report'),
              value: 'report',
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
                                _dissmissAlertDialog();
                              },
                              child: Text('No')),
                          FlatButton(
                              onPressed: () {
                                _dissmissAlertDialog();
                                DatabaseService().deleteCommentFromArticle(
                                    comment.id!, widget.articleId);
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
      ),
    );
  }

  void _dissmissAlertDialog() {
    // Navigator.pop(context);
    // Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.of(context, rootNavigator: true).pop();
  }
}
