import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Company.dart';
import 'package:flutter_interview_preparation/values/Quizz_Screen_Fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../objects/Account.dart';
import '../../objects/ArticlePost.dart';
import '../../objects/Comment.dart';
import '../../objects/Questions.dart';
import '../../values/Home_Screen_Assets.dart';
import '../../values/Home_Screen_Fonts.dart';
import '../home_screen/article/article_detail_screen.dart';
import '../home_screen/questions_answers/qa_detail_screen.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int choice = 0;
  Row searchFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              choice = 0;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: const Color(0xffD8D8D8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 1;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: const Color(0xffD8D8D8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Articles',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 2;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: const Color(0xffD8D8D8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Q&A',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              choice = 3;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 4 - 5,
            decoration: BoxDecoration(
              color: const Color(0xffD8D8D8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Company',
                  style: TextStyle(
                    fontFamily: FontFamily.urbanist,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column articlePart() {
    List _post = ArticlePost.getSampleArticlePostList();

    return Column(
        children: List.generate(_post.length, (index) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (context) => ArticleDetailScreen(),
              settings: RouteSettings(
                arguments: _post[index],
              ),
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 3),
              color: Colors.grey,
            ),
          ]),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.only(bottom: 5, left: 10),
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: _post[index].title,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 3),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: _post[index].content,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                    size: 24,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          _post[index].liked_users.length.toString(),
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    visible: true,
                  )
                ],
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );
    }));
  }

  Column qaPart() {
    List<Question> display_list_question =
        List.from(Question.getSampleQuestion());
    return Column(
        children: List.generate(3, (index) {
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
                      padding: const EdgeInsets.only(top: 3.0, bottom: 12.0),
                      child: Row(
                        children: [
                          Icon(display_list_question[index].upvote> 0
                              ? Icons.arrow_upward
                              : Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              display_list_question[index].upvote.toString(),
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
                          padding: const EdgeInsets.only(left: 5, bottom: 2),
                          child: Text(
                            display_list_question[index]
                                .answers
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
                padding: const EdgeInsets.only(left: 2.0, top: 1, bottom: 2),
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
                        for (var item
                            in display_list_question[index].categories)
                          Padding(
                            padding: const EdgeInsets.only(right: 3, bottom: 2),
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
                          Company.haveIdCompanyInSample(
                                      display_list_question[index].company_id!)
                                  ?.logo ??
                              HomeScreenAssets.lgLogo),
                    ),
                    //TimePost
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        display_list_question[index].created_at.toString(),
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
    }));
  }

  Column companyPart() {
    List _companyList = <Company>[];
    _companyList
      ..add(new Company('0', 'LG VCS DANANG', 'assets/images/lg_is.png'))
      ..add(new Company(
          '1', 'SAM SUNG ELECTRONIC VIETNAM', 'assets/images/samsung_is.png'))
      ..add(new Company(
          '2', 'TRONG HUY COMPUTER COMPANY', 'assets/images/fujitsu_is.png'));
    return Column(
        children: List.generate(_companyList.length, (index) {
      return InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: Offset(0.0, 3),
              color: Colors.grey,
            ),
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Container(
                  height: MediaQuery.of(context).size.height / 9 - 20,
                  width: MediaQuery.of(context).size.height / 9 + 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black),
                  child: Center(
                      child: Image(
                    image: AssetImage(_companyList[index].logo),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width / 10,
                  )),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: _companyList[index].name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 40,
              ),
            ],
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search'),
                ),
              ),
            ),
            searchFilter(),
            Visibility(
                visible: choice == 0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Article',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          articlePart(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questions And Answers',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          qaPart(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Company',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          companyPart()
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Article',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          articlePart(),
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 2,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Questions And Answers',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          qaPart(),
                        ],
                      ),
                    ),
                  ],
                )),
            Visibility(
                visible: choice == 3,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Company',
                            style: HomeScreenFonts.h1.copyWith(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          companyPart()
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}
