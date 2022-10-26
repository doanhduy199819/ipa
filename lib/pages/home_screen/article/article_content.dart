import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_detail_screen.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
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
    // return FutureBuilder(
    //   future: DatabaseService().getArticlesList(),
    //   builder:
    //       (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Something went wrong');
    //     }
    //     if (snapshot.data == null) {
    //       return Text('This list is null');
    //     }
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Loading");
    //     }
    //     _post = snapshot.data! as List<ArticlePost>;
    //     return Container(
    //       padding: EdgeInsets.all(4.0),
    //       child: Column(
    //         children: [
    //           Expanded(
    //             flex: 1,
    //             child: _buildTitle(),
    //           ),
    //           Expanded(
    //             flex: 7,
    //             child: _buildListViewContent(),
    //           ),
    //         ],
    //       ),
    //     );
    //     // return ListView(
    //     //   children: snapshot.data!.map((ArticlePost? articlePost) {
    //     //     return ListTile(
    //     //       title: Text(
    //     //         articlePost?.title ?? 'null',
    //     //         style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    //     //       ),
    //     //       subtitle: Text(articlePost?.content ?? 'null'),
    //     //     );
    //     //   }).toList(),
    //     // );
    //   },
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
        return Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: InkWell(
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
            //child: _buildTest(),
          ),
        );
      },
      // childCount: _post.length,
      childCount: 4,
    ));
  }

  Container _buildCustomArticleItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0.0, 3),
            color: Color.fromARGB(255, 96, 154, 241),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar+Name bloc
            Column(
              children: [
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0.0, 3),
                        color: Colors.grey,
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage(HomeScreenAssets.lgLogo),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Author: Trong Huy',
                  style: TextStyle(
                      color: Color(0xff3AB6FF), fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Content bloc
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Title
                  Container(
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'this is title',
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
                  //Content
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                    //width: 150,
                    child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'HAHA',
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
            Column(
              children: [
                Text('HAHAHA'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTest() {
    return Container(
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 2,
          offset: Offset(0.0, 3),
          color: Colors.grey,
        ),
      ]),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Column(
                    children: [
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0.0, 4),
                              color: Colors.grey,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(HomeScreenAssets.lgLogo),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Author: Trong Huy',
                        style: TextStyle(
                            color: Color(0xff3AB6FF),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Content bloc
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Title
                  Container(
                    alignment: Alignment.topLeft,
                    // margin: const EdgeInsets.only(top: 20,bottom: 20),
                    // padding: const EdgeInsets.only(top: 1, bottom: 20),
                    width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'From https://github.com/doanhduy199819/ipa',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Content
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 9 / 15 - 5,
                        padding: const EdgeInsets.only(top: 2, bottom: 2),
                        //width: 150,
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'This is content',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // React bloc
            Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 30,
                      width:110,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom( 
                          side:  BorderSide(color:Colors.white,width: 0),
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          minimumSize:  Size(70, 40),
                        ),
                        onPressed: () {},
                        child: RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                            children: [
                              // ignore: prefer_const_constructors
                              WidgetSpan(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.favorite,size: 17),
                                ),
                              ),
                              WidgetSpan(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, bottom: 3),
                                  child: const Text(
                                    'Love',
                                    style: TextStyle(color: Colors.black,fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                        width: 110,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(color:Colors.white,width: 0),
                         backgroundColor: Colors.white,
                          primary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                         // minimumSize: const Size(30, 40),
                        ),
                        onPressed: () {},
                        child: RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                            children: [
                              // ignore: prefer_const_constructors
                              WidgetSpan(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.bookmark,size: 17,),
                                ),
                              ),
                              WidgetSpan(
                                child: Container(
                                  margin: EdgeInsets.only(left: 5, bottom: 3),
                                  child: const Text(
                                    'Bookmark',
                                    style: TextStyle(color: Colors.black,fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container( 
                        height: 30,
                        width: 110,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(color:Colors.white,width: 0),
                          backgroundColor: Colors.white,
                          primary: Colors.black,
                          shadowColor: Colors.grey,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          //minimumSize: const Size(80, 2),
                        ),
                        onPressed: () {},
                        child: RichText(
                          // ignore: prefer_const_constructors
                          text: TextSpan(
                            children: [
                              // ignore: prefer_const_constructors
                              WidgetSpan(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.clear,size: 17,),
                                ),
                              ),
                              WidgetSpan(
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, bottom: 3),
                                  child: const Text(
                                    'Remove',
                                    style: TextStyle(color: Colors.black,fontSize:10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
