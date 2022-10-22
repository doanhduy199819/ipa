import 'package:flutter/material.dart';
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
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: isArticleTab == 0 ? QA() : searchPart(),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: const Color(0xffEDEAEA),
              child: isArticleTab == 0 ? Articles() : contentListQuestions(),
            ),
          ),
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

  Widget searchPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8.0, top: 2.0),
          child: Text(
            'All Questions',
            style: HomeScreenFonts.h1
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Text(
              'Company',
              style: HomeScreenFonts.h1
                  .copyWith(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.62,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xffEDEAEA),
              ),
              child: TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 1),
                  // filled: true,
                  //fillColor: Color(0xff302360),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),

                  hintStyle: const TextStyle(fontSize: 12),
                  hintText: 'Search Company',
                  prefixIcon: const Icon(Icons.search, size: 17),
                  prefixIconColor: Colors.purple.shade900,
                  // border: InputBorder.none,
                  // prefixIcon: Icon(Icons.search,size: 16,),
                  // hintText: 'Search company',
                  // hintStyle: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget contentListQuestions() {
    return ListView.custom(
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => QaDetailScreen(),
                  settings: RouteSettings(
                    arguments: display_list_question[index],
                  ),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0.0, 3),
                  color: Colors.grey,
                ),
              ]),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  //Vote bloc
                  Container(
                    padding: const EdgeInsets.only(left: 4),
                    // color:Colors.red,
                    width: MediaQuery.of(context).size.width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Vote
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 3.0, bottom: 12.0),
                          child: Row(
                            children: [
                              Icon(display_list_question[index].upvote! > 0
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  display_list_question[index]
                                      .upvote
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Comment
                        Row(
                          children: [
                            const Icon(Icons.comment),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 2),
                              child: Text(
                                display_list_question[index]
                                    .comment!
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Content bloc
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2.0, top: 1, bottom: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Title
                        Container(
                          padding: const EdgeInsets.only(top: 1, bottom: 4),
                          width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: display_list_question[index].title!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          // child: Text(
                          //   display_list_question[index].title!,
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                        //Tags
                        Row(
                          children: [
                            for (var item in display_list_question[index].tags!)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 3, bottom: 2),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  color: const Color(0xffDFE2EB),
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.visible,
                                    text: TextSpan(
                                      text: item,
                                      style: const TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  // child: Text(
                                  //   item,
                                  //   style: const TextStyle(
                                  //     color: Colors.lightBlue,
                                  //     fontSize: 12,
                                  //     fontWeight: FontWeight.w500,
                                  //   ),
                                  // ),
                                ),
                              )
                          ],
                        ),
                        //Content
                        Container(
                          width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                          padding: const EdgeInsets.only(top: 2, bottom: 2),
                          //width: 150,
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: display_list_question[index].content!,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Company bloc
                  SizedBox(
                    //color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Company Icon
                        SizedBox(
                          // padding: EdgeInsets.only(left: 15),
                          child: Image.asset(
                              alignment: Alignment.centerRight,
                              fit: BoxFit.contain,
                              width: 50,
                              height: 50,
                              display_list_question[index].company!),
                        ),
                        //TimePost
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            display_list_question[index].time!,
                            style: const TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: display_list_question.length,
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
