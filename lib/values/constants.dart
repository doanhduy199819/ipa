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
      // 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPhthE22spXytCuZqX6_MiwxI16wlJV-03UA&usqp=CAU';
      // 'https://www.manpower.com.sg/rails/active_storage/representations/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBb3RvIiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--fcd693c2fa042ddfb48d111e1fdf70004cb5bec9/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCam9VWTI5dFltbHVaVjl2Y0hScGIyNXpld2c2QzNKbGMybDZaVWtpRFRrd01IZzFNREJlQmpvR1JWUTZER2R5WVhacGRIbEpJZ3REWlc1MFpYSUdPd2RVT2dsamNtOXdTU0lRT1RBd2VEVXdNQ3N3S3pBR093ZFUiLCJleHAiOm51bGwsInB1ciI6InZhcmlhdGlvbiJ9fQ==--d35b8b0b70faef3c2f9fb225be68ae0633bc41b2/Answers%20to%207%20common%20Interview%20Questions.png';
      'https://images.pexels.com/photos/3184465/pexels-photo-3184465.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2';

  static TextStyle DETAILED_ARTICLE_TITLE = HomeScreenFonts.h1
      .copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
}
