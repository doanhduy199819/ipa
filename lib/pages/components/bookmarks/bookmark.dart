import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';

class BookmarkIcon extends StatelessWidget {
  const BookmarkIcon({
    Key? key,
    this.onBookmarkChange,
    this.isAtive = false,
  }) : super(key: key);

  final Function(bool)? onBookmarkChange;
  final bool isAtive;

  @override
  Widget build(BuildContext context) {
    return InterractionIcon(
      activeIcon: const Icon(
        Icons.bookmark_sharp,
        color: Colors.blueAccent,
      ),
      unActiveIcon: const Icon(
        Icons.bookmark_add_sharp,
        color: Colors.grey,
      ),
      hasBackgroundDecoration: false,
      isActive: isAtive,
      onActiveChange: onBookmarkChange,
    );
  }
}
