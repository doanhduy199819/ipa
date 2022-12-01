// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/article_bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:flutter_interview_preparation/values/constants.dart';
import 'package:flutter_interview_preparation/values/decoration/border_const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({Key? key}) : super(key: key);

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late Future<List<ArticlePost>?> _dataFuture;

  @override
  void initState() {
    _dataFuture = DatabaseService().allArticlesOnce;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        return Helper.handleSnapshot(snapshot) ??
            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: ArticlesList(aritcles: snapshot.data!),
              ),
            );
      },
    );
  }

  Future<void> _pullRefresh() async {
    _dataFuture = DatabaseService().allArticlesOnce;
  }
}

class ArticlesList extends StatelessWidget {
  const ArticlesList({
    Key? key,
    required this.aritcles,
  }) : super(key: key);

  final List<ArticlePost> aritcles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: aritcles.length,
      itemBuilder: (BuildContext context, int index) {
        ArticlePost article = aritcles[index];
        return InkWell(
          onTap: () {
            dynamic args = {
              "articlePost": article,
            };
            Helper.pushTo(context, const ArticleDetailScreen(), args);
          },
          child: _singleRow(
            article: article,
          ),
        );
      },
    );
  }
}

class _singleRow extends StatelessWidget {
  const _singleRow({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticlePost article;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: Constants.GREY_BOTTOM_SHADOW_BOX,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvatarAndAuthorName(authorId: article.author_id ?? '0'),
          _buildArticleTitleAndImage(article: article),
          const SizedBox(height: 8),
          _buildTimeAndInteractions(article: article),
        ],
      ),
    );
  }
}

class _buildTimeAndInteractions extends StatelessWidget {
  const _buildTimeAndInteractions({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticlePost article;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Icon(Icons.timer_rounded, color: Colors.grey, size: 14),
            const SizedBox(width: 4.0),
            Text(Helper.toFriendlyDurationTime(article.created_at),
                style: HomeScreenFonts.author),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.favorite_rounded,
                      size: 18,
                      color: Colors.red.shade300,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      article.numberOfLike.toString(),
                      style: HomeScreenFonts.description,
                    ),
                  ],
                )),
            const SizedBox(width: 16.0),
            ArticleBookmarkIcon(articlePost: article),
          ],
        ),
      ],
    );
  }
}

class _buildAvatarAndAuthorName extends StatelessWidget {
  const _buildAvatarAndAuthorName({
    Key? key,
    required this.authorId,
  }) : super(key: key);

  final String authorId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService().getFirestoreUser(authorId),
      builder: (context, AsyncSnapshot<FirestoreUser?> snapshot) =>
          Helper.handleSnapshot(snapshot) ??
          UserInfoBox(
            photoUrl: snapshot.data?.photoUrl,
            userName: snapshot.data?.displayName,
          ),
    );
  }
}

class _buildArticleTitleAndImage extends StatelessWidget {
  const _buildArticleTitleAndImage({
    Key? key,
    required this.article,
  }) : super(key: key);

  final ArticlePost article;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: RichText(
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: article.title,
              style: HomeScreenFonts.title,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: Image(
              image: NetworkImage(
                  article.photoUrl ?? Constants.SAMPLE_ARTICLE_PHOTO_URL),
              height: MediaQuery.of(context).size.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
