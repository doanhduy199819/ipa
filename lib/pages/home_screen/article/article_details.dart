// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/article_bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/buttons/follow_button.dart';
import 'package:flutter_interview_preparation/pages/components/inherited/my_inherited_data.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/components/account_part.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/components/article_comments_part.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/constants.dart';
import '../../../values/Home_Screen_Fonts.dart';
import 'package:intl/intl.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({Key? key}) : super(key: key);

  // final ArticlePost article;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  TextEditingController dropdownfieldController = TextEditingController();
  final _scrollingController = ScrollController();

  late FirestoreUser author;
  late ArticlePost articlePost;
  late UserInfoBox userInfoBox;
  late List<Comment>? comments;
  late bool checkFollow;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    articlePost = args['articlePost'] as ArticlePost;
    articlePost.categories = ['Mathematics', 'Java'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: MyInheritedData(
          scrollController: _scrollingController,
          child: SingleChildScrollView(
            controller: _scrollingController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<FirestoreUser?>(
                  future: DatabaseService()
                      .getFirestoreUser(articlePost.author_id ?? '0'),
                  builder: (context, snapshot) {
                    return Helper.handleSnapshot(snapshot) ??
                        AccountPart(
                          account: snapshot.data,
                          articlePost: articlePost,
                        );
                  },
                ),
                _buildTitle(articlePost: articlePost),
                _buildCategories(articleCategories: articlePost.categories),
                const SizedBox(height: 12),
                Center(
                  child: Image(
                    image: NetworkImage(articlePost.photoUrl ??
                        Constants.SAMPLE_ARTICLE_PHOTO_URL),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 12),
                _buildContent(content: articlePost.content ?? ''),
                const SizedBox(height: 12),
                ArticleCommentsPart(
                  articleId: articlePost.id!,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildContent extends StatelessWidget {
  const _buildContent({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(content, style: HomeScreenFonts.articleContent);
  }
}

class _buildCategories extends StatelessWidget {
  const _buildCategories({
    Key? key,
    required this.articleCategories,
  }) : super(key: key);

  final List<String>? articleCategories;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(articleCategories?.length ?? 0, (index) {
          return Container(
            decoration: Constants.GREY_BORDER_ROUND,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              articleCategories?[index] ?? '',
              style: const TextStyle(fontSize: 12),
            ),
          );
        }),
      ),
    );
  }
}

class _buildTitle extends StatelessWidget {
  const _buildTitle({
    Key? key,
    required this.articlePost,
  }) : super(key: key);

  final ArticlePost articlePost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        articlePost.title!,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 16, height: 1.6),
      ),
    );
  }
}
