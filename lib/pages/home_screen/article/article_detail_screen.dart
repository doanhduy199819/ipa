import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/SortedBy.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import '../../../objects/Questions.dart';
import '../../../values/Home_Screen_Fonts.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  String sortedBySelected = SortedBy.array[0];
  Account account=new Account('https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360', 'Nhat Tan', 2871, 100 , 100, 100);
  @override
  Widget build(BuildContext context) {
    final ArticlePost articlePost =
        ModalRoute.of(context)!.settings.arguments as ArticlePost;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Detail Article',
            style: HomeScreenFonts.h1.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 4,
        ),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                postOwner(articlePost),

                //Content of Question
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        child: title(articlePost),
                      ),
                      Padding(padding: EdgeInsets.all(8),
                      child: Text(
                        articlePost.content! +
                            ' The Interview Series has been started with the aim to let student practice solving programming questions constantly without a fail. The questions are designed in such a way that they imitate the actual interview questions asked during interviews. By solving these mock practice questions, you’ll get to evaluate your potential and where you’re lacking.  Through our interview series questions, you can get your concepts cleared before sitting for the actual coding interview. You can ace your interview preparation by participating in our recurring weekly Coding Interview Series which is devised in such a way that it will mimic the coding interview rounds of top product-based companies and service-based companies like Amazon, Google, Microsoft, PayTm, and many more IT tech giants. ',
                        style: HomeScreenFonts.content,
                      ),)
                    ],
                  ),
                ),

                answersAndSortByBloc(articlePost),
                commentBlocColumn(articlePost),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget postOwner(ArticlePost articlePost) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${account.avatar}'),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${account.name}',
              style: TextStyle(
                color: Color(0xff00BE2A),
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 5,),
              Text('${articlePost.post_time.toString()}',
                style: TextStyle(
                    fontSize: 10,
                ),),



            ],
          ),
          Spacer(),
          
          Column(
            children: [
              Icon(Icons.favorite_outline,color: Colors.red,),

              Text('${articlePost.liked_users?.length}',
                style: TextStyle(
                  fontSize: 10,
                ),),
            ],
          ),
          SizedBox(width: 20,),
          Icon(Icons.bookmark_border,color: Colors.blue,size: 24,),

        ],
      ),
    );
  }

  Widget commentBlocColumn(ArticlePost articlePost) {
    return Column(
      children: <Widget>[
        ...articlePost.comments!.map((item) {
          return commentBloc(item);
        }).toList(),
      ],
    );
  }

  Widget commentBloc(Comment comment) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 0.6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Vote Comment Bloc
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //upvote comment bloc
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: const Icon(Icons.arrow_upward),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        comment.upvote!.toString(),
                        style: HomeScreenFonts.upvote,
                      ),
                    ),
                  ],
                ),
              ),
              //answer accepted bloc
              Container(
                margin: const EdgeInsets.only(left: 8, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    comment.is_accepted == true
                        ? const Icon(
                            Icons.beenhere,
                            color: Colors.green,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          //Content comment bloc
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 12, left: 12),
                  width: MediaQuery.of(context).size.width - 70,
                  child: Text(
                    comment.content!,
                    style: HomeScreenFonts.content,
                  ),
                ),
                // Avatar Bloc
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Avatar
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 105, top: 10),
                            width: 30,
                            height: 30,
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${account!.avatar}'),
                            ),
                          ),
                        ],
                      ),
                      //Details time, profile, bloc ...
                      Container(
                        padding: const EdgeInsets.only(left: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  comment.created_at.toString()!,
                                  style: HomeScreenFonts.timePost,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Text(
                                      account!.name!,
                                      style: HomeScreenFonts.nameAccount,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  account!.numberOfPost!.toString(),
                                  style: HomeScreenFonts.numberOfPost,
                                ),

                                //Medal
                                Row(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      child: Image.asset(
                                        HomeScreenAssets.goldMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      account!.numberOfGold!.toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      child: Image.asset(
                                        HomeScreenAssets.silverMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      account!.numberOfSilver!
                                          .toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          right: 2, left: 2),
                                      width: 20,
                                      height: 20,
                                      child: Image.asset(
                                        HomeScreenAssets.bronzeMedal,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Text(
                                      account!.numberOfBronze!
                                          .toString(),
                                      style: HomeScreenFonts.numberOfPost,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget answersAndSortByBloc(ArticlePost articlePost) {
    return Container(
      height: 37,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color(0xffEDEAEA),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Text(
              '${articlePost.comments?.length} Comments',
              style: const TextStyle(
                color: Color(0xff000000),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 96, right: 5, top: 10),
                // ignore: prefer_const_constructors
                child: Text(
                  "Sort by:",
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                margin: const EdgeInsets.only(top: 10),
                height: 25,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.2),
                ),
                child: DropdownButton<String>(
                  // To delete underline in dropdownbutton
                  underline: const SizedBox(),
                  isExpanded: true,
                  value: sortedBySelected,
                  icon: const Icon(Icons.arrow_downward, size: 9),
                  elevation: 8,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      sortedBySelected = value!;
                    });
                  },
                  items: SortedBy.array
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: HomeScreenFonts.content.copyWith(
                          fontSize: 8,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget title(ArticlePost articlePost) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Title
        Container(
          padding: const EdgeInsets.only(top: 2, bottom: 4),
          child: Text(
            articlePost.title!,
            style: HomeScreenFonts.titleArticle,
          ),
        ),
      ],
    );
  }
}
