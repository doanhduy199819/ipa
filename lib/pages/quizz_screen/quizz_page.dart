import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Experience.dart';
import 'package:flutter_interview_preparation/objects/Chapter.dart';
import 'package:flutter_interview_preparation/objects/QuizSet.dart';
import 'package:flutter_interview_preparation/objects/QuizTopic.dart';
import 'package:flutter_interview_preparation/objects/StackCustom.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/experience_page.dart';
import 'package:flutter_interview_preparation/pages/quizz_screen/quizz_topic.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../values/Quizz_Screen_Assets.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  List<Experience> experiences = [];
  List<QuizSet> quizset = [];

  int currentIndexQuizzItem = 0;
  late PageController _pageController;
  late bool isViewAllQuizClicked;
  late bool isViewAllExperienceClicked;
  @override
  void initState() {
    super.initState();

    currentIndexQuizzItem = 0;
    _pageController = PageController(viewportFraction: 0.75);
    initDataExperience();
    initDataQuiz();
    isViewAllQuizClicked = false;
    isViewAllExperienceClicked = false;
  }

  void initDataExperience() {
    experiences = [
      Experience('Algorithm0', listChapter, QuizScreenAssets.img_Algorithm),
      Experience(
          'Data Structure', listChapter, QuizScreenAssets.img_DataStructure),
      Experience('Language', listChapter, QuizScreenAssets.img_Language),
    ];
  }

  void initDataQuiz() {
    quizset = [
      QuizSet('Aptitude', true, listQuizTopic),
      QuizSet('Web technologies', true, listQuizTopic),
      QuizSet('Engineering Mathematics', true, listQuizTopic),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
            child: Column(
              children: [
                // Experience Bloc
                _experienceBloc(),
                // Quizz Bloc
                _quizBloc(),
                const SizedBox(
                  height: 10,
                ),
                _recentlyQuizBloc(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recentlyQuizBloc() {
    return Column(
      children: [
        // Recently Bloc
        Row(
          children: [
            Text(
              'Recently Quizz',
              style: QuizzScreenFont.titleAppBar,
            ),
            const Spacer(),
          ],
        ),

        const SizedBox(height: 10),

        // Recently Quizz Bloc
        SizedBox(
          height: 90,
          child: PageView.builder(
            onPageChanged: (index) {
              setState(() {
                currentIndexQuizzItem = index;
              });
            },
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: recentlyQuizSet.length,
            itemBuilder: (context, index) {
              return _itemQuizzCardRecently(recentlyQuizSet[index]);
            },
          ),
        ),

        //SmoothIdicator
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 10,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: recentlyQuizSet.length,
            effect: const WormEffect(
              activeDotColor: Color(0xffC7EDE6),
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column _quizBloc() {
    return Column(
      children: [
        //quiz + ViewAll
        Row(
          children: [
            Text(
              'Quiz',
              style: QuizzScreenFont.titleAppBar,
            ),
            const Spacer(),
            // View all button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isViewAllQuizClicked == true) {
                        quizset.clear();
                        initDataQuiz();
                      } else {
                        quizset = [...listQuizSet];
                      }
                      isViewAllQuizClicked = !isViewAllQuizClicked;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffC7EDE6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View all',
                          style: QuizzScreenFont.viewAll,
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ...quizset.map((item) {
          return _itemQuizBloc(item);
        }).toList(),
      ],
    );
  }

  Column _experienceBloc() {
    return Column(
      children: [
        //Experience + ViewAll
        Row(
          children: [
            Text(
              'Experience',
              style: QuizzScreenFont.titleAppBar,
            ),
            const Spacer(),
            // View all button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (isViewAllExperienceClicked == true) {
                        experiences.clear();
                        initDataExperience();
                      } else {
                        experiences = [...listExperience];
                      }
                      isViewAllExperienceClicked=!isViewAllExperienceClicked;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 4, bottom: 4, left: 4, right: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffC7EDE6),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View all',
                          style: QuizzScreenFont.viewAll,
                        ),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        // Experience bloc
        ...experiences.map((item) {
          return _experienceItem(item);
        }).toList(),
        //_experienceItem(),
      ],
    );
  }

  Widget _itemQuizBloc(QuizSet quizSet) {
    int numberOfQuizzes = 0;
    for (var e in quizSet.listQuizTopic!) {
      numberOfQuizzes += e.listQuiz!.length;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => const QuizTopicScreen(),
            settings: RouteSettings(
              arguments: quizSet,
            ),
          ),
        ).then((value) {
          setState(() {});
        });
        // Gọi hàm then vì để setState lại recentlyQuiz, setState này sẽ gọi hàm build của QuizPage
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(QuizScreenAssets.img_bg_quizz_item),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 12),
                        child: Text(
                          quizSet.topic!,
                          style: QuizzScreenFont.titleExperience,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                          left: 12,
                        ),
                        child: Text(
                          '${quizSet.listQuizTopic!.length.toString()} Quizzes | $numberOfQuizzes  Questions',
                          style: QuizzScreenFont.textChapter,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Container(
                  //   margin: const EdgeInsets.only(right: 8),
                  //   child: Image.asset(quizSet.favourite!),
                  // ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _itemQuizzCardRecently(QuizSet quizSet) {
    int numberOfQuizzes = 0;
    quizSet.listQuizTopic!.forEach((e) {
      numberOfQuizzes += e.listQuiz!.length;
    });
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => const QuizTopicScreen(),
            settings: RouteSettings(
              arguments: quizSet,
            ),
          ),
        ).then((value) {
          setState(() {
            // for(int i=0;i<recentlyQuizSet.length-1;i++){
            //   for(int j=i+1;j<recentlyQuizSet.length;j++){
            //     if(recentlyQuizSet[i].topic!.compareTo(recentlyQuizSet[j].topic!)==0){
            //       recentlyQuizSet.removeAt(j);
            //     }
            //   }
            // }
          });
        });
        // Gọi hàm then vì để setState lại recentlyQuiz, setState này sẽ gọi hàm build của QuizPage
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 4),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * 2 / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(QuizScreenAssets.img_bg_quizz_item),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  width: MediaQuery.of(context).size.width * 2 / 3 - 40,
                  top: 12,
                  left: 4,
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: quizSet.topic!,
                      style: QuizzScreenFont.titleExperience,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 4,
                  child: Text(
                    '${quizSet.listQuizTopic!.length.toString()} Quizzes | $numberOfQuizzes  Questions',
                    style: QuizzScreenFont.textChapter,
                  ),
                ),
                const Positioned(
                  right: 10,
                  top: 12,
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(width: 2,),
        ],
      ),
    );
  }

  Widget _experienceItem(Experience experience) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: false,
            builder: (context) => const ExperiencePage(),
            settings: const RouteSettings(arguments: Experience),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xffC5E5EF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 12, left: 12),
                        child: Text(experience.title!,
                            style: QuizzScreenFont.titleExperience),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 12,
                          left: 12,
                        ),
                        child: Text(
                          '${experience.chapters!.length.toString()} chapters',
                          style: QuizzScreenFont.textChapter,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Image.asset(experience.imagePath!),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
