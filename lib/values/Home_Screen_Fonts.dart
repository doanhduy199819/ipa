import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontFamily {
  static final arial = "Arial";
  static final inter = 'Inter';
  static final urbanist = 'Urbanist';
}

class HomeScreenFonts {
  static TextStyle h1 = TextStyle(
    fontFamily: FontFamily.arial,
  );
  static TextStyle titleQuestion = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: const Color(0xff000000),
  );
  static TextStyle titleArticle = TextStyle(
    fontFamily: FontFamily.arial,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: const Color(0xff000000),
  );
  static TextStyle tagsName = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: const Color(0xff8DAAF8),
  );

  static TextStyle upvote = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 10,
    color: const Color(0xff000000),
  );
  static TextStyle comment = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 12,
    color: const Color(0xff000000),
  );
  static TextStyle timePost = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 9,
    color: const Color.fromARGB(255, 122, 114, 114),
  );
  static TextStyle nameAccount = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 11,
    color: Color.fromARGB(255, 127, 131, 192),
  );
  static TextStyle numberOfPost = TextStyle(
    fontFamily: FontFamily.inter,
    fontSize: 9,
    color: const Color(0xff000000),
  );
  static TextStyle h2 = TextStyle(
    fontFamily: FontFamily.arial,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: const Color(0xff000000),
  );
  static TextStyle header = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: FontWeight.bold,
    color: const Color(0xff000000),
  );
  static TextStyle content = GoogleFonts.ubuntu(
    fontSize: 10,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle title = GoogleFonts.montserrat(
    fontSize: 16,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static TextStyle interestTag = GoogleFonts.ubuntu(
    color: Colors.lightBlue,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle description = GoogleFonts.catamaran(
    fontSize: 14,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle author = GoogleFonts.catamaran(
    fontSize: 12,
    color: Colors.grey[900],
    fontWeight: FontWeight.normal,
  );
  static TextStyle category = GoogleFonts.roboto(
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
  static TextStyle headStyle = GoogleFonts.robotoSlab(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
