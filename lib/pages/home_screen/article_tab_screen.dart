import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article_detail_screen.dart';

import '../../objects/ArticlePost.dart';

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  State<Articles> createState() => _ArticlesState();

}



class _ArticlesState extends State<Articles> {

  List _post=<ArticlePost>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initSampleData();
  }

  


  @override
  Widget build(BuildContext context) {
    return ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate(
              (BuildContext context,int index){
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
                margin:const EdgeInsets.only(bottom: 5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0.0,3),
                        color: Colors.grey,
                      ),
                    ]
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.8 ,
                          padding: EdgeInsets.only(bottom: 5,left: 10),
                          child: RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: _post[index].title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),


                        ),

                        Container(
                          padding: EdgeInsets.only(left: 10,bottom: 3),
                          width: MediaQuery.of(context).size.width*0.8 ,
                          child:

                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: _post[index].detail,
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
                        Icon(_post[index].bookmark?Icons.bookmark:Icons.bookmark_border,color: Colors.blue,size: 24,),
                        SizedBox(height: 20,),
                        Visibility(
                          child: Row(
                            children: [
                              Icon(Icons.favorite,color: Colors.red,size: 16,),
                              SizedBox(width: 5,),
                              Text(_post[index].favorite.toString(),style: TextStyle(fontSize: 12),)
                            ],
                          ),
                          visible: _post[index].bookmark,
                        )


                      ],
                    ),
                    SizedBox(width: 15,),
                  ],
                ),
              ),
            );
          },
          childCount: _post.length,
        ));
  }
}
