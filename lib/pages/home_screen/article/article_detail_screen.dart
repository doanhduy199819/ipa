import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/SortedBy.dart';
import 'package:flutter_interview_preparation/pages/authentication/sign_up.dart';
import 'package:flutter_interview_preparation/pages/components/bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_comment.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Assets.dart';
import 'package:provider/provider.dart';
import '../../../objects/Question.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  DateFormat _formatter = DateFormat('dd-MM-yyyy');
  final _scrollingController = ScrollController();

  late FirestoreUser author;
  late ArticlePost articlePost;
  late UserInfoBox userInfoBox;
  late BookmarkIcon bookmarkIcon;
  late List<Comment>? comments;
  late String samplePhotoUrl;
  late bool checkFollow;

  void initData() {
    checkFollow = false;
    samplePhotoUrl =
        'https://media.istockphoto.com/photos/programming-code-abstract-technology-background-of-software-developer-picture-id1294521676?b=1&k=20&m=1294521676&s=170667a&w=0&h=7pqhrZcqqbQq43Q0_TD0Y_YjInAyvA9xiht9bto030U=';
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get article from parent widget

    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    articlePost = args['articlePost'] as ArticlePost;
    // userInfoBox = args['userInfo'] as UserInfoBox;
    bookmarkIcon = args['bookmark'] as BookmarkIcon;
    // articlePost = ModalRoute.of(context)!.settings.arguments as ArticlePost;
    articlePost.categories = ['Mathematics', 'Java'];

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: MyInheritedData(
            scrollController: _scrollingController,
            child: SingleChildScrollView(
              controller: _scrollingController,
              // reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<FirestoreUser?>(
                    future: DatabaseService()
                        .getFirestoreUser(articlePost.author_id ?? '0'),
                    builder: (context, snapshot) {
                      return Helper().handleSnapshot(snapshot) ??
                          AccountPart(
                            account: snapshot.data,
                            articlePost: articlePost,
                            bookmarkIcon: bookmarkIcon,
                          );
                    },
                  ),
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
            samplePhotoUrl,
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

class AccountPart extends StatefulWidget {
  AccountPart(
      {Key? key,
      required this.account,
      required this.articlePost,
      this.bookmarkIcon})
      : super(key: key);

  final FirestoreUser? account;
  final ArticlePost? articlePost;
  final BookmarkIcon? bookmarkIcon;

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
        UserInfoBox(
          photoUrl: widget.account?.photoUrl,
          userName: widget.account?.displayName,
          avatarRadius: 20.0,
          fontSize: 16.0,
        ),
        const SizedBox(width: 8),
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
          widget.articlePost?.liked_users?.length.toString() ?? '0',
          style: TextStyle(fontSize: 12),
        ),
        widget.bookmarkIcon!
        // ?? BookmarkIcon(post: widget.articlePost!),
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
