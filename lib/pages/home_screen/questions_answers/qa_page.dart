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

    // questions = Question.getSampleQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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

  // Handle when item have image company or haven't
  // Row _buildItemListView(int index) {
  //   // Test with random img , index%2==0
  //   (index % 2 == 0) ? urlImageCompany = '' : urlImageCompany = '123';

  //   return (urlImageCompany?.compareTo('') != 0)
  //       ? Row(
  //           children: [
  //             Padding(
  //               padding:
  //                   const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
  //               child: VoteBloc(
  //                   numberOfVotes: questions?[index].voteNum ?? 0,
  //                   numberOfAnswers: questions?[index].numberOfAnswers ?? 0),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: TitleTagContentQABloc(
  //                   title: questions?[index].title!,
  //                   category: questions?[index].categories,
  //                   content: questions?[index].content!,
  //                   urlImageCompany: HomeScreenAssets.lgLogo),
  //             ),
  //           ],
  //         )
  //       : Row(
  //           children: [
  //             Padding(
  //               padding:
  //                   const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
  //               child: VoteBloc(
  //                   numberOfVotes: questions?[index].voteNum ?? 0,
  //                   numberOfAnswers: questions?[index].numberOfAnswers ?? 0),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: TitleTagContentQABloc(
  //                   title: questions?[index].title!,
  //                   category: questions?[index].categories,
  //                   content: questions?[index].content!,
  //                   urlImageCompany: urlImageCompany),
  //             ),
  //             const Spacer(),
  //             //CompanyBloc(urlImage: questions?[index].company_id),
  //             const Spacer(),
  //           ],
  //         );
  // }

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
