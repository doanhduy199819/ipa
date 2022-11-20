import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/pages/home_screen/homepage.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/profile_page.dart';
import 'package:flutter_interview_preparation/pages/quiz_screen/screen/quiz_overview.dart';
import 'package:flutter_interview_preparation/pages/search_screen/search_page.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';

class HomeContainerWidget extends StatefulWidget {
  const HomeContainerWidget({Key? key}) : super(key: key);

  @override
  State<HomeContainerWidget> createState() => _HomeContainerWidgetState();
}

class _HomeContainerWidgetState extends State<HomeContainerWidget> {
  int tabIndex = 0;

  Widget _getBodyWidget(int index) {
    if (index == 0) {
      return HomePage();
      // return SafeArea(
      //     child: Container(
      //   child: Text('This is article and q&a screen'),
      // ));
    } else if (index == 1) {
      return SearchPage();
    } else if (index == 2) {
      return QuizOverview();
    } else {
      return ProfilePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBodyWidget(tabIndex),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(
          () => tabIndex = index,
        ),
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}



//  Widget homePage() {
    
//   }
// }
