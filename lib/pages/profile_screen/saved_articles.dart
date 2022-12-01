import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';

import '../../objects/FirestoreUser.dart';
import '../../objects/Comment.dart';
import '../../values/Home_Screen_Fonts.dart';

class SavedArticle extends StatefulWidget {
  const SavedArticle({Key? key}) : super(key: key);

  @override
  State<SavedArticle> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  List _postArticle = <ArticlePost>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _postArticle = ArticlePos
    // _postArticle..add(new ArticlePost(title: 'What clothes we should use in the interview day', content: 'Clothes are one of the easiest impressive point to the interviewers',comment: listComment,account: listAccount[1],love: false))
    //   ..add(new ArticlePost(title: 'Apple SDE Sheet: Interview Question & Answer', content: 'Apple is obe of the worlds holding a tight spot as one of the tech Big Four companies',comment: listComment,account: listAccount[1],love: false))
    //   ..add(new ArticlePost(title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)', content: 'Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi ',time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))
    //   ..add(new ArticlePost(title: 'What clothes we should use in the interview day', content: 'Clothes are one of the easiest impressive point to the interviewers',time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
    //   ..add(new ArticlePost(title: 'Apple SDE Sheet: Interview Question & Answer', content: 'Apple is obe of the worlds holding a tight spot as one of the tech Big Four companies',time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Your Saved Articles',
            style: HomeScreenFonts.h1.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: ListView.custom(
          childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: false,
                  builder: (context) => ArticleDetailScreen(),
                  settings: RouteSettings(
                    arguments: _postArticle[index],
                  ),
                ),
              );
            },
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
                            text: _postArticle[index].title,
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
                            text: _postArticle[index].detail,
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
                        _postArticle[index].bookmark
                            ? Icons.bookmark
                            : Icons.bookmark_border,
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
                              _postArticle[index].favorite.toString(),
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        visible: _postArticle[index].bookmark,
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
        },
        childCount: _postArticle.length,
      )),
    );
  }
}
