// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';

class Constants {
  static const GREY_BOTTOM_SHADOW_BOX = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        blurRadius: 1,
        offset: Offset(0.0, 3),
        color: Colors.grey,
      ),
    ],
  );
  static const BLUE_BACKGROUND_ROUND = BoxDecoration(
    color: Colors.blueAccent,
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );
  static BoxDecoration GREY_BACKGROUND_ROUND = BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
  );
  static BoxDecoration GREY_BORDER_ROUND = BoxDecoration(
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(24),
  );

  static const SAMPLE_ARTICLE_PHOTO_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhthE22spXytCuZqX6_MiwxI16wlJV-03UA&usqp=CAU';

  static TextStyle DETAILED_ARTICLE_TITLE = HomeScreenFonts.h1
      .copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
}