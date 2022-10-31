import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({Key? key}) : super(key: key);

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late List<ArticlePost> _post;

  @override
  void initState() {
    // TODO: implement initState
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
          return Text('Something went wrong');
        }
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
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
                      padding: const EdgeInsets.only(bottom: 5, left: 10),
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: _post[index].title,
                          // text: 'a',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, bottom: 3),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: _post[index].content,
                          // text: 'a',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: Colors.blue,
                      size: 24,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: true,
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
                            _post[index].liked_users?.length.toString() ?? '0',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        );
      },
      childCount: _post.length,
    ));
  }
}
