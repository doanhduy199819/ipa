import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/pages/home_screen/comment_box.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../objects/Account.dart';
import '../../../objects/ArticlePost.dart';
import '../../../objects/Comment.dart';

class ArticleCommentPart extends StatefulWidget {
  String id;
  ArticleCommentPart({Key? key, required this.id}) : super(key: key);

  @override
  State<ArticleCommentPart> createState() => _ArticleCommentPartState();
}

class _ArticleCommentPartState extends State<ArticleCommentPart> {
  late List<Comment>? comments;
  late Account account;
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  String commentContent = "";
  final _formKey = GlobalKey<FormState>();
  final _textFieldController = TextEditingController();

  @override
  void initState() {
    account = new Account(
        'https://images.pexels.com/photos/5245865/pexels-photo-5245865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'Nhat Tan',
        2871,
        100,
        100,
        100);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: DatabaseService().commentsFromArticle(widget.id),
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
          Container(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _textFieldController,
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
              ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint('Sent comment button is pressed');
                    _sendComment(commentContent);
                    _clearCommentContent();
                    FocusManager.instance.primaryFocus?.unfocus();
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
                },
              ),
            ],
          )
        ],
      ),
    );
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
  void _sendComment(String content) {
    DatabaseService().addCommentToArticle(content, widget.id);
  }

  // Clear commentInput
  void _clearCommentContent() {
    _textFieldController.clear();
  }

  // List of comments of this article
  Widget commentsList(List<Comment>? comments) {
    return Column(
      // controller: _scrollingController,
      children: <Widget>[
        ...?comments?.map((comment) => commentBloc(comment)).toList()
      ],
    );
    // return ListView.builder(
    //     controller: _scrollingController,
    //     itemBuilder: (_, index) =>
    //         (comments != null) ? commentBloc(comments[index]) : Row());
  }

  // Each comment in commentsList
  Widget commentBloc(Comment comment) {
    return CommentBoxWidget(
      photoUrl: account.avatar,
      userName: account.name,
      isShowingUpvote: false,
      content: comment.content,
    );
  }
}
