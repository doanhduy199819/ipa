import 'package:flutter/material.dart';
import '../../values/Home_Screen_Fonts.dart';
import '../home_screen/questions_answers/components/listview_qa.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/components/listview_qa.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../home_screen/questions_answers/components/question_content.dart';
import '../home_screen/questions_answers/qa_detail_screen.dart';


class QAForSearch extends StatefulWidget {
  String searchTitle;
  QAForSearch({Key? key,required this.searchTitle}) : super(key: key);


  @override
  State<QAForSearch> createState() => _QAForSearchState();
}

class _QAForSearchState extends State<QAForSearch> {

  late List<Question>? questions;

  @override
  void initState() {
    super.initState();
  }

  void searchFunction()
  {
    questions=questions?.where((element) => element.title!.toLowerCase().contains(this.widget.searchTitle.toLowerCase())).toList();
  }

  Future<void> _pullRefresh() async {
    setState(() async {
      questions = await DatabaseService().allQuestionsOnce;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allQuestionsOnce,
      builder:
          (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong :(');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        questions = snapshot.data! as List<Question>;
        searchFunction();
        return Container(
            padding: EdgeInsets.all(4.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: questions?.length!=0,
                  child: Text(
                    'Question and Answer',
                    style: HomeScreenFonts.h1.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),),

                SizedBox(
                  height: 5,
                ),
                qaPart(),
              ],
            )

        );
      },
    );  }

  Widget qaPart()
  {
   return Column(
       children: List.generate(questions!.length, (index) {
         return InkWell(
           onTap: () {
             Navigator.push(
               context,
               MaterialPageRoute(
                 fullscreenDialog: false,
                 builder: (context) => const QaDetailScreen(),
                 settings: RouteSettings(
                   arguments: questions?[index],
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
             child: buildQuestionContent(question: questions![index]),
           ),
         );
       }));
  }
}
