import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/QuizSet.dart';
import 'package:flutter_interview_preparation/objects/QuizTopic.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quiz_discription.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Assets.dart';
import '../../values/Home_Screen_Assets.dart';
import '../../values/Quizz_Screen_Fonts.dart';

class QuizTopicScreen extends StatefulWidget {
  const QuizTopicScreen({Key? key}) : super(key: key);

  @override
  State<QuizTopicScreen> createState() => _QuizTopicScreenState();
}

class _QuizTopicScreenState extends State<QuizTopicScreen> {
  @override
  Widget build(BuildContext context) {
    double widthOfDevice = MediaQuery.of(context).size.width;
    final QuizSet quizSet =
        ModalRoute.of(context)!.settings.arguments as QuizSet;
    return Scaffold(
      backgroundColor: const Color(0xffD8F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffD8F5F5),
        title: Text(
          quizSet.topic!,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 8, left: 8, top: 16, bottom: 16),
          child: Column(
            children: [
              // Topic bloc
              for (int i = 0; i < listQuizTopic.length; i++)
                if (i % 2 == 0 && i < listQuizTopic.length - 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      topicRowBloc(listQuizTopic[i], widthOfDevice),
                      topicRowBloc(listQuizTopic[i + 1], widthOfDevice),
                    ],
                  )
                else if (i % 2 == 0 && i == listQuizTopic.length - 1)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      topicRowBloc(listQuizTopic[i], widthOfDevice),
                      SizedBox(
                        width: widthOfDevice / 10 * 3.5,
                        height: widthOfDevice / 10 * 3.7,
                      ),
                    ],
                  )
            ],
          ),
        ),
      ),
    );
  }

  Widget topicRowBloc(QuizTopic quizTopic, double widthOfDevice) {
    int numberOfQuizzDone = 0;
    // for (var e in quizTopic.listQuiz!) {
    //   if (e.myAnswer >0) {
    //     numberOfQuizzDone++;
    //   }
    // }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => const QuizDiscription(),
          ),
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: widthOfDevice / 10 * 3.5,
                height: widthOfDevice / 10 * 3.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    // Image bloc
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 25, left: 30),
                          height: widthOfDevice / 10 * 3.5 / 10 * 5,
                          width: widthOfDevice / 10 * 3.5 / 10 * 4.6,
                          child: Image.asset(QuizScreenAssets.img_topic),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 30,
                          height: 30,
                          child: quizTopic.favourite == true
                              ? Image.asset(
                                  QuizScreenAssets.img_favourite_topic)
                              : Image.asset(
                                  QuizScreenAssets.img_unfavourite_topic),
                        ),
                      ],
                    ),
                    Text(
                      '$numberOfQuizzDone / ${quizTopic.listQuiz!.length} Questions',
                      style: QuizzScreenFont.numberOfQuizDone,
                    ),
                    Text(
                      '${quizTopic.topic}',
                      style: QuizzScreenFont.topic,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
