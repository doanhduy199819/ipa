import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/async.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/bookmark.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class ArticleBookmarkIcon extends StatefulWidget {
  const ArticleBookmarkIcon({Key? key, required this.articlePost})
      : super(key: key);

  final ArticlePost articlePost;

  @override
  State<ArticleBookmarkIcon> createState() => _ArticleBookmarkIconState();
}

class _ArticleBookmarkIconState extends State<ArticleBookmarkIcon> {
  late Stream<bool> _savedState;

  @override
  void initState() {
    _savedState =
        DatabaseService().isArticlePostSaved(widget.articlePost.id ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _savedState,
        builder: (context, isSavedSnapshot) {
          return Helper.handleSnapshot(isSavedSnapshot, const BookmarkIcon()) ??
              BookmarkIcon(
                isAtive: isSavedSnapshot.data!,
                onBookmarkChange: (isActive) {
                  isActive
                      ? DatabaseService().saveArticle(widget.articlePost)
                      : DatabaseService().unSaveArticle(widget.articlePost);
                },
              );
        });
  }
}
