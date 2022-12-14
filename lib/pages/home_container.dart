import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/experiences_screen/screens/experiences_home_screen.dart';
import 'package:flutter_interview_preparation/pages/home_screen/homepage.dart';
import 'package:flutter_interview_preparation/pages/home_screen/questions_answers/qa_page.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/quiz_overview/quiz_overview.dart';
import 'package:flutter_interview_preparation/pages/search_screen/search_page.dart';

class HomeContainerWidget extends StatefulWidget {
  const HomeContainerWidget({Key? key}) : super(key: key);

  @override
  State<HomeContainerWidget> createState() => _HomeContainerWidgetState();
}

class _HomeContainerWidgetState extends State<HomeContainerWidget> {
  int tabIndex = 0;
  Widget _getBodyWidget(int index) {
    if (index == 0) {
      return const HomePage();
    } else if (index == 1) {
      // return QAContent();
      return const QAPage();
    } else if (index == 2) {
      return SearchPage();
    }else if (index == 3) {
      return ExperienceHome();
    } else {
      return QuizOverview();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: _getBodyWidget(tabIndex),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Theme.of(context).secondaryHeaderColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => setState(
            () => tabIndex = index,
          ),
          currentIndex: tabIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), label: 'Q & A'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Experience'),
            BottomNavigationBarItem(
                icon: Icon(Icons.assignment), label: 'Quiz'),
          ],
        ),
      ),
    );
  }
}