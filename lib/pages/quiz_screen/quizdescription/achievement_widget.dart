import 'package:flutter/material.dart';

class AchievementWidget extends StatelessWidget {
  BoxDecoration imgInAchievementBoxDecor;
  AchievementWidget({Key? key, required this.imgInAchievementBoxDecor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: Container(
        width: 30,
        height: 30,
        // ignore: prefer_const_constructors
        decoration: imgInAchievementBoxDecor,
      ),
    );
  }
}
