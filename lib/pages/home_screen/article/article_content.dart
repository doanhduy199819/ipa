import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({Key? key}) : super(key: key);

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late List<ArticlePost> _post;
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final bool like_check = false;
    final bool bookmard_check = false;
    // _initSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().allArticlesOnce,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong :(');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: [
              CircularProgressIndicator(),
            ],
          );
        }
        _post = snapshot.data! as List<ArticlePost>;
        return Container(
          padding: EdgeInsets.all(4.0),
          child: _buildListViewContent(),
        );
      },
    );
  }

  void _initSampleData() {
    _post = ArticlePost.getSampleArticlePostList();
  }

  ListView _buildListViewContent() {
    return ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => const ArticleDetailScreen(),
                settings: RouteSettings(
                  arguments: _post[index],
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(0.0, 3),
                color: Colors.grey,
              ),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                padding:
                                    const EdgeInsets.only(bottom: 4, left: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                      size: 14,
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: _post[index].author_id,
                                        style: HomeScreenFonts.description,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.65,
                          padding: const EdgeInsets.only(bottom: 4, left: 8),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: _post[index].title,
                              // text: 'a',
                              style: HomeScreenFonts.title,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                text: _post[index].content,
                                // text: 'a',
                                style: HomeScreenFonts.content),
                          ),
                        ),
                      ],
                    ),
                    //Spacer(),
                    SizedBox(
                      width: 12,
                    ),
                    Image(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhthE22spXytCuZqX6_MiwxI16wlJV-03UA&usqp=CAU'),
                      width: MediaQuery.of(context).size.width * 0.26,
                      //                    height: MediaQuery.of(context).size.height * 0.20,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8, bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: Colors.grey,
                            size: 14,
                          ),
                          RichText(
                            text: TextSpan(
                              text: ' ' +
                                  _calculatorDateAgo(_post[index].created_at),
                              // text: 'a',
                              style: HomeScreenFonts.description,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    FlatButton(
                        onPressed: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 21,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                _buildLike(_post[index].liked_users?.length),
                                style: HomeScreenFonts.description,
                              ),
                            ],
                          ),
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.bookmark_border_rounded,
                        size: 21,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      childCount: _post.length,
    ));
  }

  String _calculatorDateAgo(DateTime? dt) {
    return Jiffy(dt).fromNow();
  }

  String _buildLike(int? sl) {
    return sl == null ? '0' : '${sl}';
  }
}
