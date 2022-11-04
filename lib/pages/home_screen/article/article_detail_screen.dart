import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/SortedBy.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import '../../../objects/Questions.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  String sortedBySelected = SortedBy.array[0];
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  late Account account;
  late ArticlePost articlePost;
  late List<Comment>? comments;
  late String imageUrl;
  late bool checkFollow;
  void initData() {
    checkFollow = false;
    imageUrl =
        'https://media.istockphoto.com/photos/programming-code-abstract-technology-background-of-software-developer-picture-id1294521676?b=1&k=20&m=1294521676&s=170667a&w=0&h=7pqhrZcqqbQq43Q0_TD0Y_YjInAyvA9xiht9bto030U=';
    account = new Account(
        'https://images.pexels.com/photos/5245865/pexels-photo-5245865.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        'Nhat Tan',
        2871,
        100,
        100,
        100);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // get article from parent widget
    articlePost = ModalRoute.of(context)!.settings.arguments as ArticlePost;
    articlePost.categories = ['Mathematics', 'Java'];
    print(articlePost.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text(
            'Detail Articles',
            style: HomeScreenFonts.h1.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            top: 16,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  accountPart(),
                  buildTitle(),
                  Row(
                    children: [
                      postedTime(),
                      Spacer(),
                      listCategory(),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  imageArticle(),
                  SizedBox(
                    height: 16,
                  ),
                  articleContent(),
                  commentsPart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<List<Comment>?> commentsPart() {
    return StreamBuilder(
        stream: DatabaseService().commentsFromArticle(articlePost.id!),
        builder: (BuildContext context,
            AsyncSnapshot<List<Comment>?> asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return Text('Something went wrong :(');
          }
          if (asyncSnapshot.data == null ||
              asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                CircularProgressIndicator(),
              ],
            );
          }
          comments = asyncSnapshot.data;
          return Column(
            children: [
              answersAndSortByBloc(comments),
              commentBlocColumn(comments),
            ],
          );
        });
    ;
  }

  void _loadComments(List<Comment>? comments) {
    articlePost.setComments(comments);
  }

  // Widget commentBlocColumn(ArticlePost articlePost) {
  Widget commentBlocColumn(List<Comment>? comments) {
    return Column(
      children: <Widget>[
        // ...articlePost.comments!.map((item) {
        //   return commentBloc(item);
        // }).toList(),
        ...?comments?.map((comment) => commentBloc(comment)).toList()
      ],
    );
  }

  Widget commentBloc(Comment comment) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(),
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
                                  comment.created_at.toString(),
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
                                      account!.numberOfSilver!.toString(),
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
                                      account!.numberOfBronze!.toString(),
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

  // Widget answersAndSortByBloc(ArticlePost articlePost) {
  Widget answersAndSortByBloc(List<Comment>? comments) {
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
              '${comments?.length ?? 0} Comments',
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

  Row accountPart() {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(account.avatar!),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Text(
              account.name!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 5,
        ),
        InkWell(
          onTap: () {
            setState(() {
              checkFollow = !checkFollow;
            });
          },
          child: checkFollow == false
              ? Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 7,
                  ),
                  child: Text(
                    'Follow',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              : Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 7,
                  ),
                  child: Text(
                    'Followed',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ),
        ),
        const Spacer(),
        Icon(
          Icons.favorite,
          color: Colors.red,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          articlePost.liked_users == null
              ? '0'
              : articlePost.liked_users!.length.toString(),
          style: TextStyle(fontSize: 12),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.bookmark_add_outlined),
        ),
      ],
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        articlePost.title!,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.6),
      ),
    );
  }

  Text postedTime() {
    return Text(
      'posted on ' + formatter.format(articlePost.created_at!),
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Row listCategory() {
    return Row(
        children: List.generate(articlePost.categories!.length, (index) {
      return Container(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Center(
                child: Text(articlePost.categories![index]),
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
      );
    }));
  }

  Container imageArticle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Text articleContent() {
    return Text(
      articlePost.content!,
      style: TextStyle(
          fontSize: 12,
          height: 1.6,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamily.urbanist),
    );
  }
}
