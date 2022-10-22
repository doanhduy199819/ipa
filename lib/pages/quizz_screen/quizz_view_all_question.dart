import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Quiz.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/view_single_question.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Fonts.dart';

import '../../values/Home_Screen_Assets.dart';

class ViewAllQuestion extends StatefulWidget {
  const ViewAllQuestion({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ViewAllQuestionState();
}

class _ViewAllQuestionState extends State<ViewAllQuestion> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffD8F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xffD8F5F5),
          title: Text(
            'View all questions',
            style: QuizzScreenFont.titleAppBar,
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
          actions: [
            Card(
                color: Colors.blue,
                margin: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: InkWell(
                  onTap: () {
                    //do something
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Need help ?',
                        style: QuizzScreenFont.topic,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ))
          ],
        ),
        body: myGridView(),
      ),
    );
  }

  Widget myGridView() {
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, mainAxisSpacing: 10, crossAxisSpacing: 10),
      children: [
        for (var i = 0; i < listQuiz.length; i++)
          Card(
              color: isDone==false?
              (listQuiz[i].myAnswer>-1? Colors.lightGreen : Colors.white) :
              (listQuiz[i].myAnswer==listQuiz[i].correctAnswer?Colors.green:Colors.red),
              margin: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: InkWell(
                onTap: (() {
                  currentQuestion=i;
                  Navigator.of(context).pop();
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${i+1}',
                      style: QuizzScreenFont.topic,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ))
      ],
    );
  }
}
