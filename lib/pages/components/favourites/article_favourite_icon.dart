// ignore_for_file: implementation_imports

import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/favourites/favourite_icon.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class ArticleFavouriteIcon extends StatefulWidget {
  const ArticleFavouriteIcon({Key? key, required this.articlePost})
      : super(key: key);

  final ArticlePost articlePost;

  @override
  State<ArticleFavouriteIcon> createState() => _ArticleFavouriteIconState();
}

class _ArticleFavouriteIconState extends State<ArticleFavouriteIcon> {
  late Stream<bool> _likedState;

  @override
  void initState() {
    _likedState =
        DatabaseService().isArticlePostLiked(widget.articlePost.id ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _likedState,
        builder: (context, islikedSnapshot) {
          return Helper.handleSnapshot(
                  islikedSnapshot, const FavouriteIcon()) ??
              FavouriteIcon(
                isAtive: islikedSnapshot.data!,
                onFavouriteChange: (isActive) {
                  isActive
                      ? DatabaseService()
                          .unLikeArticle(widget.articlePost.id ?? '')
                      : DatabaseService()
                          .likeArticle(widget.articlePost.id ?? '');
                },
              );
        });
  }
}
