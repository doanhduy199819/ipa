import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/pages/home_container.dart';
import 'package:flutter_interview_preparation/pages/home_screen/search_company_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

import '../../values/Home_Screen_Assets.dart';

class PostAnArticle extends StatefulWidget {
  const PostAnArticle({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostAnArticleState();
}

class _PostAnArticleState extends State<PostAnArticle> {
  String? title;
  String? content;
  DateTime? created_at;
  ArticlePost? myArticlePost;
  @override
  Widget build(BuildContext context) {
    return //MaterialApp(
        // home :
        Scaffold(
            backgroundColor: const Color(0xffD8F5F5),
            appBar: AppBar(
              backgroundColor: const Color(0xffD8F5F5),
              title: Text(
                'Post An Article',
                style: HomeScreenFonts.header,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  HomeScreenAssets.backButton,
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text('Title ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left),
                  Text(
                      'Be specific and imagine you’re asking a question to another person',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Title',
                      fillColor: Colors.lightBlue[100],
                      filled: true,
                    ),
                    onChanged: (text) {
                      title = text;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Content',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left),
                  Text(
                      'Include all the information someone would need to answer your question',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 10,
                  ),
                  _buildContentField(),
                  Text('Related Fields :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left),
                  SizedBox(
                    height: 5,
                  ),
                  _buildRelatedField(),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Company :',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.left),
                  Text('N/A',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                      textAlign: TextAlign.left),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: RaisedButton(
                        color: Colors.black,
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Notice'),
                              content:
                                  const Text('Do you sure post an article'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    created_at = DateTime.now();
                                    myArticlePost = ArticlePost(
                                        null,
                                        title,
                                        created_at,
                                        content,
                                        null,
                                        null,
                                        null,
                                        null);
                                    DatabaseService()
                                        .addArticle(myArticlePost!);
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeContainerWidget()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ); //do something
                        }),
                  ),
                ],
              ),
            )

            //   ),
            );
  }


  Widget _buildContentField() {
    final maxLines = 10;
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 40,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      //do something
                    },
                    icon: Icon(Icons.format_bold)),
                IconButton(
                    onPressed: () {
                      //do something
                    },
                    icon: Icon(Icons.format_italic)),
                IconButton(
                    onPressed: () {
                      //do something
                    },
                    icon: Icon(Icons.format_underline)),
                IconButton(
                    onPressed: () {
                      //do something
                    },
                    icon: Icon(Icons.image)),
                IconButton(
                    onPressed: () {
                      //do something
                    },
                    icon: Icon(Icons.folder)),
              ],
            ),
          ),
          Container(
            height: maxLines * 24.0,
            child: TextField(
              onChanged: (text) {
                content = text;
              },
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: "Content",
                fillColor: Colors.lightBlue[100],
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedField() {  
    return Container(
      child: Row(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            //color: Colors.cyanAccent[100],//after tab this card
            color: Colors.grey[300],
            elevation: 2,
            child: FlatButton(
              child: Text(
                'Experience',
                style: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                //do something
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            //color: Colors.cyanAccent[100],//after tab this card
            color: Colors.grey[300],
            elevation: 2,
            child: FlatButton(
              child: Text(
                'Tips',
                style: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                //do something
              },
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            //color: Colors.cyanAccent[100],//after tab this card
            color: Colors.grey[300],
            elevation: 2,
            child: FlatButton(
              child: Text(
                'Knowledge',
                style: TextStyle(fontSize: 14),
              ),
              onPressed: () {
                //do something
              },
            ),
          ),
        ],
      ),
    );
  }
}
