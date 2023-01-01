import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/listview_qa.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/tag_fillter.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/post_a_question.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import '../../../objects/UserBlocked.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'components/company_bloc.dart';

class QAPage extends StatefulWidget {
  const QAPage({Key? key}) : super(key: key);

  @override
  State<QAPage> createState() => _QAPageState();
}

class _QAPageState extends State<QAPage> {
  late int currentlyIndexFillters;
  late List<Question>? questions;
  late List<String> fillters;
  late String? urlImageCompany;
  late Future<List<UserBlocked>?> _userBlockedFuture;

  @override
  void initState() {
    super.initState();

    currentlyIndexFillters = 0;

    urlImageCompany = '';

    fillters = <String>[
      "Interesting",
      "Hot",
      "Week",
      "Month",
    ];

    FirebaseFirestore _db = FirebaseFirestore.instance;

    _userBlockedFuture = _db
        .collection('userwasblocked')
        .get()
        .then(_userBlockedsFromQuerySnapshot);
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (AuthService().currentUser?.isAnonymous == true) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text(
                      'You Need Login To Post A Question',
                    ),
                    actions: [
                      TextButton(
                        child: const Text("Cancle"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                          child: const Text("Login"),
                          onPressed: () {
                            Navigator.pop(context);
                            AuthService().signOut();
                          }),
                    ],
                  );
                });
            return;
          }

          var usersblocked = await _userBlockedFuture;
          for (int i = 0; i < usersblocked!.length; i++) {
            if (usersblocked[i].id_user == AuthService().currentUser!.uid) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text(
                        'USER WAS BANNED',
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  });
              return;
            }
          }
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostAQuestion(),
                fullscreenDialog: false,
              ));
        },
        backgroundColor: Colors.lightBlue.shade400,
        child: const Icon(Icons.add_comment),
      ),
      appBar: _buildAppBar(),
      backgroundColor: const Color.fromARGB(255, 233, 240, 243),
      body: Column(
        children: [
          const _buildTitle(),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BuildTagFillter(
                    fillters: fillters,
                    currentlyIndexFillters: currentlyIndexFillters),
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: FutureBuilder<List<Question>?>(
                future: DatabaseService().allQuestionsOnce,
                builder: (context, snapshot) {
                  questions = snapshot.data;
                  return RefreshIndicator(
                    onRefresh: _pullRefresh,
                    child: Helper.handleSnapshot(snapshot) ??
                        ListViewQAWidget(questions: questions),
                  );
                }),
          )
        ],
      ),
    );
  }

  Future<void> _pullRefresh() async {
    // setState(() async {
    //   questions = await DatabaseService().allQuestionsOnce;
    // });
  }

  

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Q & A',
        style: HomeScreenFonts.headStyle,
      ),
    );
  }
}

class _buildTitle extends StatelessWidget {
  const _buildTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Text(
            'Top Questions',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
