import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({
    Key? key,
    this.onFavouriteChange,
    this.isAtive = false,
  }) : super(key: key);

  final Function(bool)? onFavouriteChange;
  final bool isAtive;

  @override
  Widget build(BuildContext context) {
    return InterractionIcon(
      activeIcon: Icon(
        Icons.favorite_rounded,
        color: Colors.red.shade300,
      ),
      unActiveIcon: const Icon(
        Icons.favorite_outline_rounded,
        color: Colors.grey,
      ),
      hasBackgroundDecoration: false,
      isActive: isAtive,
      onActiveChange: onFavouriteChange,
    );
  }
}
