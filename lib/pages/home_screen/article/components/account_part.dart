import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/pages/components/buttons/follow_button.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';

import '../../../components/bookmarks/article_bookmark.dart';

class AccountPart extends StatelessWidget {
  const AccountPart(
      {Key? key,
      required this.account,
      required this.articlePost,})
      : super(key: key);

  final FirestoreUser? account;
  final ArticlePost articlePost;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserInfoBox(
          photoUrl: account?.photoUrl,
          userName: account?.displayName,
          avatarRadius: 20.0,
          fontSize: 16.0,
        ),
        const SizedBox(width: 8),
        const FollowButton(),
        const Spacer(),
        const Icon(Icons.favorite, color: Colors.red),
        const SizedBox(width: 4),
        Text(
          articlePost.liked_users?.length.toString() ?? '0',
          style: const TextStyle(fontSize: 12),
        ),
        ArticleBookmarkIcon(articlePost: articlePost),
      ],
    );
  }
}