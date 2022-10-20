import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article_detail_screen.dart';

import '../../objects/Articles.dart';

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
    _post..add(new ArticlePost(title: 'What clothes we should use in the interview day', detail: 'Clothes are one of the easiest impressive point to the interviewers', bookmark: true, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'OOP is a must for a C++ developer', detail: 'Most of us have studied Object-Oriented Programming at the university', bookmark: false, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'Apple SDE Sheet: Interview Question & Answer', detail: 'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies', bookmark: true, favorite: 2871,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)', detail: 'Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi Nguyen Duy Nhat Tan luoi viet lam roi ', bookmark: true, favorite: 666,time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))
      ..add(new ArticlePost(title: 'What clothes we should use in the interview day', detail: 'Clothes are one of the easiest impressive point to the interviewers', bookmark: true, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'OOP is a must for a C++ developer', detail: 'Most of us have studied Object-Oriented Programming at the university', bookmark: false, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))
      ..add(new ArticlePost(title: 'Apple SDE Sheet: Interview Question & Answer', detail: 'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies', bookmark: true, favorite: 2871,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)', detail: 'Nguyen Duy Nhat Tan luoi viet lam roi....', bookmark: true, favorite: 666,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'What clothes we should use in the interview day', detail: 'Clothes are one of the easiest impressive point to the interviewers', bookmark: true, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))
      ..add(new ArticlePost(title: 'OOP is a must for a C++ developer', detail: 'Most of us have studied Object-Oriented Programming at the university', bookmark: false, favorite: 1412,time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))
      ..add(new ArticlePost(title: 'Apple SDE Sheet: Interview Question & Answer', detail: 'Apple is obe of the worlds favorite tech brand, holding a tight spot as one of the tech Big Four companies', bookmark: true, favorite: 2871,time: '28/07/2022',comment: listComment,account: listAccount[1],love: false))
      ..add(new ArticlePost(title: 'How to Prepare for eLitmus Hiring Potential Test(pH Test)', detail: 'Nguyen Duy Nhat Tan luoi viet lam roi....', bookmark: true, favorite: 666,time: '28/07/2022',comment: listComment,account: listAccount[1],love: true))

    ;
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
