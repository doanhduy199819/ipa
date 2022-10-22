import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Quiz.dart';
import 'package:flutter_interview_preparation/objects/QuizTopic.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_page.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_topic.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/view_single_question.dart';

class QuizDiscription extends StatefulWidget {
  const QuizDiscription({super.key});

  @override
  State<QuizDiscription> createState() => _QuizDiscriptionState();
}

class _QuizDiscriptionState extends State<QuizDiscription> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String title = "HTML and XML";

    String description =
        "This is a quiz for all the programmers about HTML and XML";
    return Scaffold(
      body: Stack(
        children: <Widget>[
          BackgroundImage(
              link_image: "assets/images/QuizDescription__BackgroundImage.png"),
          SingleChildScrollView(
              child: Column(
            children: [
              Container(height: size.height * 0.35),
              Stack(
                children: [
                  Container(
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 240, 255, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [TitleQuiz(title: title), ButtonStart()]),
                      DescriptionQuiz(description: description),
                      BoxWhatYouWillLearn(size: size),
                      BoxSkill(size: size),
                    ],
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class BoxSkill extends StatelessWidget {
  const BoxSkill({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      padding: EdgeInsets.only(left: 10, top: 10),
      height: 100,
      width: size.width - 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 252, 255, 1),
          border: Border.all(width: 1.0, color: Colors.black),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "WHAT WILL YOU LEARN",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),
          )
        ],
      ),
    );
  }
}

class BoxWhatYouWillLearn extends StatelessWidget {
  const BoxWhatYouWillLearn({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      padding: EdgeInsets.only(left: 10, top: 10),
      height: 175,
      width: size.width - 50,
      decoration: BoxDecoration(
          color: Color.fromRGBO(243, 252, 255, 1),
          border: Border.all(width: 1.0, color: Colors.black),
          borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "WHAT WILL YOU LEARN",
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
          ),
        ),
        ShowList(text: "Describe the basics of the HTML and XML"),
        ShowList(text: "Describe the basics of the HTML and XML"),
        ShowList(text: "Describe the basics of the HTML and XML"),
        ShowList(text: "Describe the basics of the HTML and XML"),
      ]),
    );
  }
}

class DescriptionQuiz extends StatelessWidget {
  const DescriptionQuiz({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Text(
        description,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          fontFamily: "Arial",
        ),
      ),
    );
  }
}

class ButtonStart extends StatelessWidget {
  const ButtonStart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => ViewSingleQuestionWidget()
          ),
        ).then((value) {listQuiz.clear();});
      },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 50,
        width: 110,
        decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.circular(50)),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "START QUIZ",
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),
          ),
        ),
      ),
    );
  }
}

class TitleQuiz extends StatelessWidget {
  const TitleQuiz({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10),
      width: size.width - 120,
      child: Text(
        title,
        style: TextStyle(
          decoration: TextDecoration.none,
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Arial",
        ),
      ),
    );
  }
}

class ShowList extends StatelessWidget {
  const ShowList({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/list.png"),
                fit: BoxFit.scaleDown),
          ),
        ),
        Expanded(
            child: Text(text,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Arial",
                )))
      ],
    );
  }
}

class ImageStar extends StatelessWidget {
  const ImageStar({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/icons/star.png"),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

class ImageHaftStar extends StatelessWidget {
  const ImageHaftStar({super.key, required this.size});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/icons/haft_star.png"),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.link_image,
  });

  final String link_image;

  @override
  Widget build(BuildContext context) {
    // image size : height->576, width->354
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage(link_image),
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
