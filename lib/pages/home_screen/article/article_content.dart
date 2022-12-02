// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/article_bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/bookmarks/bookmark.dart';
import 'package:flutter_interview_preparation/pages/components/interaction_icon.dart';
import 'package:flutter_interview_preparation/pages/components/user_info_box.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/articles_list.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:flutter_interview_preparation/values/Home_Screen_Fonts.dart';
import 'package:flutter_interview_preparation/values/constants.dart';
import 'package:flutter_interview_preparation/values/decoration/border_const.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ArticleContent extends StatefulWidget {
  const ArticleContent({Key? key}) : super(key: key);

  @override
  State<ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<ArticleContent> {
  late Future<List<ArticlePost>?> _dataFuture;

  @override
  void initState() {
    _dataFuture = DatabaseService().allArticlesOnce;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        return Helper.handleSnapshot(snapshot) ??
            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: ArticlesList(aritcles: snapshot.data!),
              ),
            );
      },
    );
  }

  Future<void> _pullRefresh() async {
    _dataFuture = DatabaseService().allArticlesOnce;
  }
}

