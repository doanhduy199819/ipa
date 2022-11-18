import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class BookmarkIcon extends StatefulWidget {
  const BookmarkIcon({Key? key, required this.post})
      : super(key: key);

  final ArticlePost post;

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
            future: DatabaseService()
                .isInUserSaved(widget.post),
            builder: (context, snapshot) {
              debugPrint(snapshot.data.toString());
              return snapshot.connectionState == ConnectionState.waiting
                  ? Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.bookmark_add_sharp, color: Colors.grey))
                  : InterractionIcon(
                      isActive: snapshot.data ?? false,
                      activeIcon: const Icon(
                        Icons.bookmark_sharp,
                        color: Colors.blueAccent,
                      ),
                      unActiveIcon: const Icon(
                        Icons.bookmark_add_sharp,
                        color: Colors.grey,
                      ),
                      hasBackgroundDecoration: false,
                      onActiveChange: (isActive) async {
                        isActive
                            ? await DatabaseService()
                                .saveArticle(widget.post)
                            : await DatabaseService()
                                .unSaveArticle(widget.post);
                      },
                    );
            });
  }
}
