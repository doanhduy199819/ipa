import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/pages/components/buttons/follow_button.dart';
import 'package:flutter_interview_preparation/pages/components/favourites/article_favourite_icon.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../components/bookmarks/article_bookmark.dart';

class AccountPart extends StatefulWidget {
  const AccountPart({
    Key? key,
    required this.account,
    required this.articlePost,
  }) : super(key: key);

  final FirestoreUser? account;
  final ArticlePost articlePost;

  @override
  State<AccountPart> createState() => _AccountPartState();
}

class _AccountPartState extends State<AccountPart> {
  late Stream<int> _likesStream;

  @override
  void initState() {
    // TODO: implement initState
    _likesStream = DatabaseService()
        .getArticle(widget.articlePost.id ?? '')
        .map((article) => article.numberOfLike);
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
        const FollowButton(),
        const Spacer(),
        ArticleFavouriteIcon(articlePost: widget.articlePost),
        const SizedBox(width: 4),
        StreamBuilder<int>(
            stream: _likesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Text('0', style: TextStyle(fontSize: 12));
              }
              return Text(
                snapshot.data?.toString() ?? '0',
                style: const TextStyle(fontSize: 12),
              );
            }),
        ArticleBookmarkIcon(articlePost: widget.articlePost),
      ],
    );
  }
}
