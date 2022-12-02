import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/article_bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:flutter_interview_preparation/values/constants.dart';

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
