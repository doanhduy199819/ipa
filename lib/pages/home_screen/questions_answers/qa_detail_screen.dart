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
  // String sortedBySelected = SortedBy.array[0];

  @override
  void initState() {
    // TODO: implement initState
    currentSortOption = sortOptions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Question question =
        ModalRoute.of(context)?.settings.arguments as Question;

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
                //Content of Question
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  decoration:
                      const BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      offset: Offset(0.0, 3),
                      color: Colors.grey,
                    ),
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: buildQuestionContent(
                      question: question,
                      isShowingDetail: true,
                    ),
                  ),
                ),

                answersAndSortByBloc(question),
                // commentBlocColumn(question),
                QAComments(questionId: question.id ?? '0')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commentBlocColumn(Question question) {
    return Column(
      children: <Widget>[
        if (question.answers != null)
          //Map => add vào toList xong rã ra từng Widget = ...
          ...(question.answers!.map((item) {
            return commentBloc(item);
          }).toList()),
      ],
    );
  }

  Widget commentBloc(Comment comment) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Vote Comment Bloc
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //upvote comment bloc
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: const Icon(Icons.arrow_upward),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        comment.upvote.toString(),
                        style: HomeScreenFonts.upvote,
                      ),
                    ),
                  ],
                ),
              ),
              //answer accepted bloc
              Container(
                margin: const EdgeInsets.only(left: 8, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    comment.is_accepted ?? false
                        ? const Icon(
                            Icons.beenhere,
                            color: Colors.green,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          //Content comment bloc
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  width: MediaQuery.of(context).size.width - 70,
                  child: Text(
                    comment.content!,
                    style: HomeScreenFonts.content,
                  ),
                ),
                // Avatar Bloc
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 105, top: 10),
                            width: 30,
                            height: 30,
                            child: CircleAvatar(
                              backgroundImage:
                                  // Task: Account avatar
                                  // NetworkImage('${comment.account!.avatar}'),
                                  NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360'),
                            ),
                          ),
                        ],
                      ),
                      //Details time, profile, bloc ...
                      Container(
                        padding: const EdgeInsets.only(left: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  parseDateTime(comment.created_at),
                                  style: HomeScreenFonts.timePost,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Text(
                                      // Task: accouunt name
                                      // comment.account!.name!,
                                      'Duy',
                                      style: HomeScreenFonts.nameAccount,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  // Task
                                  // comment.account!.numberOfPost!.toString(),
                                  10.toString(),
                                  style: HomeScreenFonts.numberOfPost,
                                ),

                                //Medal
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      child: Image.asset(
                                        HomeScreenAssets.goldMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      // Task
                                      // comment.account!.numberOfGold!.toString(),
                                      20.toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      child: Image.asset(
                                        HomeScreenAssets.silverMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      // Task
                                      // comment.account!.numberOfSilver!
                                      //     .toString(),
                                      20.toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        HomeScreenAssets.bronzeMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      // Task
                                      // comment.account!.numberOfBronze!
                                      //     .toString(),
                                      20.toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget answersAndSortByBloc(Question question) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
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

  Widget titleAndTagBloc(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        Container(
          padding: const EdgeInsets.only(top: 2, bottom: 4),
          width: MediaQuery.of(context).size.width * 9 / 15 - 5,
          child: Text(
            question.title!,
            style: HomeScreenFonts.titleQuestion,
          ),
        ),
        //Tags
        (question.categories != null)
            ? Row(
                children: [
                  for (var item in question.categories!)
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 3, bottom: 2, top: 2),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          color: const Color(0xffDFE2EB),
                          child: Text(item, style: HomeScreenFonts.tagsName)),
                    )
                ],
              )
            : Row(
                children: const [
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
      ],
    );
  }

//Widget companybloc
  Widget companyBloc(Question question) {
    return SizedBox(
      //color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Company Icon
          SizedBox(
            // padding: EdgeInsets.only(left: 15),
            child: Image.asset(
                alignment: Alignment.centerRight,
                fit: BoxFit.contain,
                width: 50,
                height: 40,
                //question.company!
                // TODO: change image
                // Company.haveIdCompanyInSample(question.company_id)?.logoUrl ??
                HomeScreenAssets.lgLogo),
          ),
          //TimePost
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              parseDateTime(question.created_at),
              style: const TextStyle(
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Widget VoteBloc
  Widget voteBloc(Question question) {
    return Container(
      padding: const EdgeInsets.only(left: 4),
      // color:Colors.red,
      width: MediaQuery.of(context).size.width / 6.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vote
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
            child: Row(
              children: [
                Icon(question.numberOfUpvote > 0
                    ? Icons.arrow_upward
                    : Icons.arrow_downward),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text(
                    question.numberOfDownvote.toString(),
                    style: HomeScreenFonts.upvote,
                  ),
                ),
              ],
            ),
          ),
          // Comment
          Row(
            children: [
              const Icon(Icons.comment),
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 2),
                child: Text(
                  question.numberOfAnswers.toString(),
                  style: HomeScreenFonts.comment,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String parseDateTime(DateTime? time) {
    if (time != null) {
      String formatter = DateFormat('dd/MM/yyyy').format(time);
      return formatter;
    } else {
      return '1/1/2001';
    }
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
            child: Helper().handleSnapshot(snapshot) ??
                UserInfoBox(
                  userName: author?.displayName,
                  photoUrl: author?.photoUrl,
                  avatarRadius: 16.0,
                ),
          );
        });
  }
}
