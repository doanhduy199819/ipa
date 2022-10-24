import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Quiz.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/view_single_question.dart';

import '../../values/Home_Screen_Assets.dart';

class QuizResult extends StatefulWidget {
  const QuizResult({Key? key}) : super(key: key);

  @override
  State<QuizResult> createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  int correct=0;
  int incorrect=0;

  @override
  void initState() {
    for(int i=0;i<listQuiz.length;i++)
      {
        if(selectedAnswers[i]==listQuiz[i].correctAnswer)
          correct++;
        else
          incorrect++;
      }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/quizresult_background.png'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(
                    HomeScreenAssets.backButton,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Center(
              child: Image(image: AssetImage('assets/images/red_carpet.png'),height: 120,),
            ),
            Text('Congratulation!',style: TextStyle(
              fontSize: 22,
              color:  const Color(0xff019455F),
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 5,),
            Text('You have sucessfully completed',style: TextStyle(
              color:  const Color(0xff019455F),
              fontWeight: FontWeight.w300
            ),)
            ,SizedBox(height: 10,),
            Text('Web technologies',style: TextStyle(
                color:  const Color(0xff019455F),
              fontSize: 18
            ),),

            SizedBox(height: 80,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, left: 4, right: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5EFFF),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/correct.png'),height: 35,),
                      Text(
                        '$correct correct',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 50,),
                Container(

                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, left: 4, right: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xffD5EFFF),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/incorrect.png'),height: 35,),
                      Text(
                        '$incorrect incorrect',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 80,),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                padding: const EdgeInsets.only(
                    top: 4, bottom: 4, left: 4, right: 4),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(232, 242, 249, 0.75),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/images/reset.png'),height: 35,),
                    Text(
                      'Redo the quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              onTap: (){
                listQuiz.clear();
                selectedAnswers.clear();
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width-40,

              padding: const EdgeInsets.only(
                  top: 4, bottom: 4, left: 4, right: 4),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(232, 242, 249, 0.75)
                ,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                      Text(
                        'Web technologies 2',
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.chevron_right,size: 35,)


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
