import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

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
    // _initSampleData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getArticlesList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.data == null) {
          return Text('This list is null');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        _post = snapshot.data! as List<ArticlePost>;
        return Container(
          padding: EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: _buildTitle(),
              ),
              Expanded(
                flex: 7,
                child: _buildListViewContent(),
              ),
            ],
          ),
        );
        // return ListView(
        //   children: snapshot.data!.map((ArticlePost? articlePost) {
        //     return ListTile(
        //       title: Text(
        //         articlePost?.title ?? 'null',
        //         style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        //       ),
        //       subtitle: Text(articlePost?.content ?? 'null'),
        //     );
        //   }).toList(),
        // );
      },
    );
  }

  void _initSampleData() {
    _post = ArticlePost.getSampleArticlePostList();
  }

  Row _buildTitle() {
    return Row(
      children: const [
        Text(
          'Popular articles',
          style: TextStyle(
              color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  ListView _buildListViewContent() {
    return ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return InkWell(
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       fullscreenDialog: false,
              //       builder: (context) => const ArticleDetailScreen(),
              //       settings: RouteSettings(
              //         arguments: _post[index],
              //       ),
              //     ),
              //   );
              // },
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
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: MediaQuery.of(context).size.width * 0.15-20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/5245865/pexels-photo-5245865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Center(
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Nhat Tan',
                                // text: 'a',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,

                          padding: const EdgeInsets.only(bottom: 5, left: 10),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: _post[index].title,
                              // text: 'a',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.78,
                          padding: const EdgeInsets.only(bottom: 5, left: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    _post[index].liked_users?.length.toString() ==
                                        null
                                        ? '0 like'
                                        : '${_post[index].liked_users?.length.toString()} likes',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 10),
                                  )
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.schedule, size: 20),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    formatter.format(_post[index].created_at!),
                                    style: TextStyle(fontSize: 10),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          // childCount: _post.length,
          childCount: _post.length,
        ));
  }
}
