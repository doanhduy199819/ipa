import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:intl/intl.dart';
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
  final _controller = TextEditingController();

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
              headingComment(comments),
              SizedBox(
                height: 10,
              ),
              commentBox(comments),
              Divider(),
              commentBlocColumn(comments),
            ],
          );
        });
  }

  Container commentBox(List<Comment>? comments) {
    print('hechhc');
    return Container(
      child: Column(
        children: [
          Container(
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _controller,
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
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Container headingComment(List<Comment>? comments) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            'Comments',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Positioned(
              left: 85,
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        comments == null ? '0' : comments!.length.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  )))
        ],
      ),
    );
  }

  void _sendComment(String content) {
    DatabaseService().addCommentToArticle(content, widget.id);
  }

  void _clearCommentContent() {
    _controller.clear();
  }

  Widget commentBlocColumn(List<Comment>? comments) {
    return Column(
      children: <Widget>[
        // ...articlePost.comments!.map((item) {
        //   return commentBloc(item);
        // }).toList(),
        ...?comments?.map((comment) => commentBloc(comment)).toList()
      ],
    );
  }

  Widget commentBloc(Comment comment) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(account.avatar!), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              account.name!,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(Icons.more_horiz)
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          comment.content!,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade700,
              fontSize: 12),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Icon(
              Icons.favorite_outline,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              comment!.upvote.toString(),
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              color: Colors.grey,
              height: 15,
              width: 1,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Reply',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              color: Colors.grey,
              height: 15,
              width: 1,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              formatter.format(comment.created_at!),
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade400,
              ),
            )
          ],
        ),
        Divider(),
      ],
    );
  }
}
