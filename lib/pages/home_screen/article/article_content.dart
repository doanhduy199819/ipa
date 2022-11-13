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
  late bool like_check;
  late bool bookmard_check;

  void initData() {
    like_check = false;
    bookmard_check = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
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
    return ListView.builder(
      // childrenDelegate: SliverChildBuilderDelegate(
      // separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
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
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  offset: Offset(0.0, 3),
                  color: Colors.grey,
                ),
              ],
              // borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 14,
                            ),
                            Text(
                              _post[index].author_id.toString(),
                              style: HomeScreenFonts.author,
                            ),
                          ],
                        )),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: const EdgeInsets.only(left: 8, bottom: 4),
                          child: RichText(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: _post[index].title,
                              // text: 'a',
                              style: HomeScreenFonts.title,
                            ),
                          ),
                        ),

                        // Container(
                        //   padding: const EdgeInsets.only(left: 8, bottom: 4),
                        //   width: MediaQuery.of(context).size.width * 0.65,
                        //   child: RichText(
                        //     maxLines: 3,
                        //     overflow: TextOverflow.ellipsis,
                        //     text: TextSpan(
                        //         text: _post[index].content,
                        //         // text: 'a',
                        //         style: HomeScreenFonts.content),
                        //   ),
                        // ),
                      ],
                    ),
                    //Spacer(),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      //         alignment: Alignment.center,
                      child: Image(
                        image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhthE22spXytCuZqX6_MiwxI16wlJV-03UA&usqp=CAU',
                        ),
                        width: MediaQuery.of(context).size.width * 0.21,
                        height: MediaQuery.of(context).size.height * 0.07,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_rounded,
                            // color: Color.fromARGB(255, 217, 130, 0),
                            color: Colors.grey,
                            size: 14,
                          ),
                          Text(
                            ' ' + _buildCreate_at(_post[index].created_at),
                            // text: 'a',
                            style: HomeScreenFonts.author,
                          ),
                          // RichText(
                          //   text: TextSpan(
                          //     text: _calculatorDateAgo(_post[index].created_at),
                          //     // text: 'a',
                          //     style: HomeScreenFonts.author,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Text(
                                _buildLike(_post[index].liked_users?.length),
                                style: HomeScreenFonts.description,
                              ),
                            ],
                          ),
                        )),
                    InkWell(
                      child: Icon(
                        Icons.bookmark_border_rounded,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 12,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: _post.length,
    );
  }

  // String _calculatorDateAgo(DateTime? dt) {
  //   return Jiffy(dt).fromNow();
  // }

  String _buildLike(int? sl) {
    return sl == null ? '0' : '${sl}';
  }

  String _buildCreate_at(DateTime? dateTime) {
    return dateTime?.year == DateTime.now().year
        ? Jiffy(dateTime).MMMd.toString()
        : Jiffy(dateTime).fromNow();
  }
}
