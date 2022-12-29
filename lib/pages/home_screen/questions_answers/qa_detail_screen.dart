import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/up_down_vote_box.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/qa_comments.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/question_content.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import '../../../objects/Company.dart';
import '../../../objects/Question.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

class QaDetailScreen extends StatefulWidget {
  const QaDetailScreen({Key? key}) : super(key: key);

  @override
  State<QaDetailScreen> createState() => _QaDetailScreenState();
}

class _QaDetailScreenState extends State<QaDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  final sortOptions = [
    'Highest score (default)',
    'Trending (recent votes count more)',
    'Date modified (newest first)',
    'Date created (oldest first)',
  ];
  late String? currentSortOption;
  late Question question;
  // String sortedBySelected = SortedBy.array[0];

  @override
  void initState() {
    // TODO: implement initState
    currentSortOption = sortOptions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    question = ModalRoute.of(context)?.settings.arguments as Question;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(backgroundColor: Colors.transparent),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                authorBloc(question: question),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: buildQuestionContent(
                    question: question,
                    isShowingDetail: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FutureBuilder<int>(
                    future: _getDefaultUpDownVoteState(),
                    builder: (context, snapshot) {
                      return Helper.handleSnapshot(snapshot) ??
                          UpDownVoteBox(
                            iconSize: 16.0,
                            isHorizontal: true,
                            upVoteHandle: _handleUpvote,
                            downVoteHandle: _handleDownvote,
                            defaultVoteState: snapshot.data,
                          );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: answersAndSortByBloc(question),
                ),
                (AuthService().currentUser?.isAnonymous == true)
                    ? Center(
                        child: TextButton(
                          child: const Text(
                            'Login To Comment',
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            AuthService().signOut();
                          },
                        ),
                      )
                    : QAComments(questionId: question.id ?? '0')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleUpvote(bool isUpvote) {
    DatabaseService().upVoteQuestion(question, !isUpvote);
    if (!isUpvote) DatabaseService().downVoteQuestion(question, false);
  }

  void _handleDownvote(bool isDownvote) {
    DatabaseService().downVoteQuestion(question, !isDownvote);
    if (!isDownvote) DatabaseService().upVoteQuestion(question, false);
  }

  Future<int> _getDefaultUpDownVoteState() async {
    if (await DatabaseService().isAlreadyVoteQuestion(question, true)) {
      return 1;
    } else if (await DatabaseService().isAlreadyVoteQuestion(question, false)) {
      return -1;
    }
    return 0;
  }

  Widget answersAndSortByBloc(Question question) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          child: Text(
            '${question.numberOfAnswers} Answers',
            style: const TextStyle(
              color: Color(0xff000000),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        const Text(
          "Sort by:",
          style: TextStyle(fontSize: 10, fontFamily: 'Arial'),
        ),
        Container(
          margin: const EdgeInsets.only(left: 12),
          padding: const EdgeInsets.only(left: 12),
          // width: 130,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.2),
          ),
          child: DropdownButton<String>(
            // To delete underline in dropdownbutton
            underline: const SizedBox(),
            value: currentSortOption,
            style: const TextStyle(color: Colors.black),
            onChanged: (val) {
              // This is called when the user selects an item.
              setState(() {
                currentSortOption = val;
              });
            },
            items: sortOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: HomeScreenFonts.content.copyWith(
                    fontSize: 8,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class authorBloc extends StatelessWidget {
  const authorBloc({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirestoreUser?>(
        future: DatabaseService().getFirestoreUser(question.author_id ?? '0'),
        builder: (context, snapshot) {
          final author = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(left: 48.0),
            child: Helper.handleSnapshot(snapshot) ??
                UserInfoBox(
                  userName: author?.displayName,
                  photoUrl: author?.photoUrl,
                  avatarRadius: 16.0,
                ),
          );
        });
  }
}
