import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_container.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/qa_page.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/change_password_page.dart';
import 'package:flutter_interview_preparation/pages/wrapper.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:provider/provider.dart';

import '../../../objects/Company.dart';

class PostAQuestion extends StatefulWidget {
  const PostAQuestion({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostAQuestionState();
}

Color color = Colors.red;
String? title;
String? content;
DateTime? created_at;
String? author_id;
String? company_id;
String? currentCompany_name = 'N/A';
List<String>? categories;
String? tags;
List<Company>? listCompany = [];

class _PostAQuestionState extends State<PostAQuestion> {
  bool isShowCompany = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffD8F5F5),
        appBar: AppBar(
          foregroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Post A Question',
            style: HomeScreenFonts.headStyle,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                'Title :',
                style: HomeScreenFonts.title,
              ),
              Text(
                'Be spescific and imagine you’re asking a question to another person',
                style: HomeScreenFonts.content,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Title :",
                  fillColor: Colors.lightBlue[100],
                  filled: true,
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              Text('Content', style: HomeScreenFonts.title),
              Text(
                'Include all the information someone would need to answer your question',
                style: HomeScreenFonts.content,
              ),
              _buildContentField(),
              Text('Related Fields :',
                  style: HomeScreenFonts.title, textAlign: TextAlign.left),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter tags",
                  fillColor: Colors.lightBlue[100],
                  filled: true,
                ),
                onChanged: (value) {
                  tags = value;
                },
              ),
              InkWell(
                child: Column(
                  children: [
                    Text(
                      'Company :',
                      style: HomeScreenFonts.title,
                      textAlign: TextAlign.left,
                    ),
                    Text('${currentCompany_name ?? ''}',
                        style: HomeScreenFonts.description,
                        textAlign: TextAlign.left),
                  ],
                ),
                onTap: () async {
                  listCompany = await DatabaseService().allCompanyOnce;
                  showDialog(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
                      return MyDialog();
                    },
                  ).then((value) {
                    setState(() {
                      currentCompany_name = value;
                    });
                  });
                },
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      color: Colors.black,
                      child: const Text(
                        'Post',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('MESSAGE'),
                          content:
                              const Text('Do you sure post this question ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  author_id = AuthService().currentUserId;
                                  company_id = getIdCompany();
                                  categories = tags?.split(",");
                                  created_at = DateTime.now();
                                  Question newQues = Question(
                                      null,
                                      title,
                                      content,
                                      created_at,
                                      author_id,
                                      company_id,
                                      categories,
                                      null,
                                      null,
                                      null);
                                  DatabaseService().addQuestion(newQues);
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ).then((value) {
                        _showToast(context);
                        Navigator.pop(context);
                      });
                    }),
              ),
            ],
          ),
        ));
  }
}

String? getIdCompany() {
  String? idCom;
  List<String>? listCompanyId = [];
  listCompany?.forEach((element) {
    print('${element.id}');
    if (element.name == currentCompany_name) idCom = element.id;
  });

  return idCom;
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
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: "Content",
              fillColor: Colors.lightBlue[100],
              filled: true,
            ),
            onChanged: (value) {
              content = value;
            },
          ),
        ),
      ],
    ),
  );
}

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 180,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            ...(listCompany!
                .map((e) => Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 200,
                            height: 60,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                Text(
                                  '${e.name}',
                                  style: HomeScreenFonts.title,
                                ),
                                Spacer(),
                                Icon(Icons.navigate_next)
                              ],
                            ),
                          ),
                          onTap: (() {
                            setState(() {
                              Navigator.pop(context, e.name);
                            });
                          }),
                        ),
                      ],
                    ))
                .toList()),
          ],
        ),
      ),
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text('Posted question'),
      action:
          SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
