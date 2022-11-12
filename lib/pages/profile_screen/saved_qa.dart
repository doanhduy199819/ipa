import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/qa_detail_screen.dart';

import '../../objects/Question.dart';
import '../../values/Home_Screen_Fonts.dart';

class SavedQuestion extends StatefulWidget {
  const SavedQuestion({Key? key}) : super(key: key);

  @override
  State<SavedQuestion> createState() => _SavedQuestionState();
}

class _SavedQuestionState extends State<SavedQuestion> {
  // List<Question> display_list_question = List.from(listQuestion);
  List<Question> display_list_question = <Question>[];
  // late List<Question> display_list_question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Your Saved Questions',
            style: HomeScreenFonts.h1.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => QaDetailScreen(),
                    settings: RouteSettings(
                      arguments: display_list_question[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration:
                    const BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    offset: Offset(0.0, 3),
                    color: Colors.grey,
                  ),
                ]),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    //Vote bloc
                    Container(
                      padding: const EdgeInsets.only(left: 4),
                      // color:Colors.red,
                      width: MediaQuery.of(context).size.width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vote
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 3.0, bottom: 12.0),
                            child: Row(
                              children: [
                                Icon(display_list_question[index]
                                            .numberOfUpvote >
                                        0
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    display_list_question[index]
                                        .numberOfUpvote
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
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
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 2),
                                child: Text(
                                  display_list_question[index]
                                          .answers
                                          ?.length
                                          .toString() ??
                                      '0',
                                  style: const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //Content bloc
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 2.0, top: 1, bottom: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Title
                          Container(
                            padding: const EdgeInsets.only(top: 1, bottom: 4),
                            width:
                                MediaQuery.of(context).size.width * 9 / 15 - 5,
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: display_list_question[index].title!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          //Tags
                          Row(
                            children: [
                              for (var item
                                  in display_list_question[index].categories ??
                                      [])
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 3, bottom: 2),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    color: const Color(0xffDFE2EB),
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.visible,
                                      text: TextSpan(
                                        text: item,
                                        style: const TextStyle(
                                          color: Colors.lightBlue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                          //Content
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 9 / 15 - 5,
                            padding: const EdgeInsets.only(top: 2, bottom: 2),
                            //width: 150,
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: display_list_question[index].content!,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Company bloc
                    SizedBox(
                      //color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Company Icon
                          SizedBox(
                              // padding: EdgeInsets.only(left: 15),

                              // TODO: Edit later
                              // child: Image.asset(
                              //     alignment: Alignment.centerRight,
                              //     fit: BoxFit.contain,
                              //     width: 50,
                              //     height: 50,
                              //     display_list_question[index].company!),
                              ),
                          //TimePost
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              display_list_question[index]
                                  .created_at
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: display_list_question.length,
        ),
      ),
    );
  }
}
