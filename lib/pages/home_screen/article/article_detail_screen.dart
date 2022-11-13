import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Account.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/SortedBy.dart';
import 'package:flutter_interview_preparation/pages/authentication/sign_up.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_comment.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:provider/provider.dart';
import '../../../objects/Question.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

class AccountPart extends StatefulWidget {
  Account account;
  ArticlePost articlePost;
  AccountPart({Key? key, required this.account, required this.articlePost})
      : super(key: key);

  @override
  State<AccountPart> createState() => _AccountPartState();
}

class _AccountPartState extends State<AccountPart> {
  late bool checkFollow;
  void initData() {
    checkFollow = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          // radius: 24,
          backgroundImage: NetworkImage(widget.account.avatar!),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Text(
              widget.account.name!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {
            setState(() {
              checkFollow = !checkFollow;
            });
          },
          child: checkFollow == false
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Text(
                    'Follow',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
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
          width: 4,
        ),
        Text(
          widget.articlePost.liked_users == null
              ? '0'
              : widget.articlePost.liked_users!.length.toString(),
          style: TextStyle(fontSize: 12),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.bookmark_add_outlined),
        ),
      ],
    );
  }
}

class MyInheritedData extends InheritedWidget {
  const MyInheritedData({
    super.key,
    required this.scrollController,
    required super.child,
  });

  final ScrollController scrollController;

  static MyInheritedData of(BuildContext context) {
    final MyInheritedData? result =
        context.dependOnInheritedWidgetOfExactType<MyInheritedData>();
    assert(result != null, 'No Data found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(MyInheritedData oldWidget) =>
      scrollController != oldWidget.scrollController;
}

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  String sortedBySelected = SortedBy.array[0];
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  final _scrollingController = ScrollController();

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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          children: [
            Positioned(
              left: 16,
              right: 16,
              bottom: 0,
              top: 16,
              child: MyInheritedData(
                scrollController: _scrollingController,
                child: SingleChildScrollView(
                  controller: _scrollingController,
                  // reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AccountPart(account: account, articlePost: articlePost),
                      buildTitle(),
                      Row(
                        children: [
                          Spacer(),
                          listCategory(),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      imageArticle(),
                      articleContent(),
                      SizedBox(
                        height: 20,
                      ),
                      //comment
                      ArticleCommentPart(
                        articleId: articlePost.id!,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
