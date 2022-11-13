import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/title_tag_content_bloc.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/vote_bloc.dart';

import '../../../../values/Home_Screen_Assets.dart';
import '../qa_detail_screen.dart';
import 'company_bloc.dart';

class ListViewQAWidget extends StatelessWidget {

  List<Question>? questions;
  String? urlImageCompany;
  ListViewQAWidget({Key? key, required this.questions, required this.urlImageCompany}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.custom(
                childrenDelegate:
                    SliverChildBuilderDelegate(childCount: questions!.length,
                        (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          fullscreenDialog: false,
                          builder: (context) => QaDetailScreen(),
                          settings: RouteSettings(
                            arguments: questions![index],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),                  
                      child: _buildItemListView(index),
                    ),
                  );
                }),
              ),
            );
  }

    // Handle when item have image company or haven't
  Row _buildItemListView(int index) {
    // Test with random img , index%2==0
    (index % 2 == 0) ? urlImageCompany = '' : urlImageCompany = '123';

    return (urlImageCompany!.compareTo('') != 0)
        ? Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
                child: VoteBloc(
                    numberOfVotes: questions![index].numberOfUpvote -
                        questions![index].numberOfDownvote,
                    numberOfAnswers: questions![index].numberOfAnswers),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TitleTagContentQABloc(
                    title: questions![index].title!,
                    category: questions![index].categories,
                    content: questions![index].content!,
                    urlImageCompany: HomeScreenAssets.lgLogo),
              ),
            ],
          )
        : Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 4.0),
                child: VoteBloc(
                    numberOfVotes: questions![index].numberOfUpvote -
                        questions![index].numberOfDownvote,
                    numberOfAnswers: questions![index].numberOfAnswers),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TitleTagContentQABloc(
                    title: questions![index].title!,
                    category: questions![index].categories,
                    content: questions![index].content!,
                    urlImageCompany: urlImageCompany),
              ),
              const Spacer(),
              CompanyBloc(
                  idCompany: questions![index].company_id,
                  timePosted: questions![index].created_at),
              const Spacer(),
            ],
          );
  }
}