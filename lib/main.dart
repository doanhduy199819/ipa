import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/home_screen/homepage.dart';
import 'package:flutter_interview_preparation/pages/home_screen/list_questions_screen.dart';
import 'package:flutter_interview_preparation/pages/interest_screen/Interest_Page.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/profile_page.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_page.dart';
import 'package:flutter_interview_preparation/pages/search_screen/search_page.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Colors.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: InterestWidget(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final screens = [HomePage(), SearchPage(), QuizzPage(), ProfilePage()];
  int sc = 0;

  @override
  Widget build(BuildContext context) {
    return homePage();
  }

  Widget homePage() {
    return Scaffold(
      body: screens[sc],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(
          () => sc = index,
        ),
        currentIndex: sc,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
            ),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.profile_circled,
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
