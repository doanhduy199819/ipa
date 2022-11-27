import 'package:flutter/material.dart';

import '../../objects/Question.dart';
import '../../services/database_service.dart';
import '../../values/Home_Screen_Fonts.dart';
import '../home_screen/questions_answers/components/question_content.dart';
import '../home_screen/questions_answers/qa_detail_screen.dart';

class CompanyQA extends StatefulWidget {
  String idCompany;
  String nameCompany;
  CompanyQA({Key? key,required this.idCompany,required this.nameCompany}) : super(key: key);


  @override
  State<CompanyQA> createState() => _CompanyQAState();
}

class _CompanyQAState extends State<CompanyQA> {

  late List<Question> questions;

  @override
  void initState() {
    super.initState();
  }

  void getQuestion()
  {
    questions=questions.where((element) => element.company_id!.contains(this.widget.idCompany)).toList();

  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        'Questions about '+widget.nameCompany,
        style: HomeScreenFonts.headStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: const Color.fromARGB(255, 233, 240, 243),
      body: ListView(
        children: [
          FutureBuilder(
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
              getQuestion();
              return qaPart();
            },
          )
        ],
      ),
    );  }

  Widget qaPart()
  {
    return Column(
        children: List.generate(questions.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => const QaDetailScreen(),
                  settings: RouteSettings(
                    arguments: questions[index],
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
              child: buildQuestionContent(question: questions[index]),
            ),
          );
        }));
  }
}
