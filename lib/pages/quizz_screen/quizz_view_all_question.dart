import 'package:flutter/material.dart';
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffD8F5F5),
        appBar: AppBar(
          backgroundColor: const Color(0xffD8F5F5),
          title: Text(
            'Question 1 of 30',
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
        for (var i = 1; i <= 30; i++)
          Card(
              color: Colors.lightGreen,
              margin: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: InkWell(
                onTap: (() {
                  //do something;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '$i',
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
