import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_content.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article_tab_screen.dart';
import 'package:flutter_interview_preparation/pages/home_screen/qa_detail_screen.dart';
import 'package:flutter_interview_preparation/pages/home_screen/qa_tab_screen.dart';
import 'package:flutter_interview_preparation/pages/profile_screen/profile_page.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Colors.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import '../../objects/Questions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int isArticleTab = 0;
  List<Question> display_list_question = List.from(listQuestion);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isArticleTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: _buildTopBanner(), // Extract to method for short code
          ),
          Expanded(
            flex: 1,
            child: _buildTabView(),
          ),
          // Expanded(child: Container(color: Colors.pink.shade200), flex: 7)
          Expanded(
            child: ArticleContent(),
            flex: 7,
          )
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     color: Colors.white,
          //     child: isArticleTab == 0 ? QA() : searchPart(),
          //   ),
          // ),
          // Expanded(
          //   flex: 7,
          //   child: Container(
          //     color: const Color(0xffEDEAEA),
          //     child: isArticleTab == 0 ? Articles() : contentListQuestions(),
          //   ),
          // ),
        ],
      ),
    );
  }

  Row _buildTopBanner() {
    return Row(
      children: [
        Expanded(
          // color: Colors.yellow,
          // padding: EdgeInsets.all(16.0),
          child: Image.asset(
            HomeScreenAssets.banner,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildTabView() {
    // Change name
    return DefaultTabController(
      length: 2,
      child: Material(
        color: HomeScreenColors.primaryColor,
        child: TabBar(
          onTap: (index) {
            onTapHandle(index);
          },
          indicatorColor: const Color(0xffF0B10E),
          indicatorWeight: 5,
          tabs: const [
            Tab(
              child: Text(
                'Articles',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Questions & Answers',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapHandle(int index) {
    setState(() {
      {
        // ignore: avoid_print
        print('Index: $index , isArticleTab: $isArticleTab');
        if (index != 0) {
          isArticleTab = 1;
        } else {
          isArticleTab = 0;
        }
      }
    });
  }
}
