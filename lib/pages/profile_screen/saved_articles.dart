import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/article_details.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/articles_list.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../objects/FirestoreUser.dart';
import '../../objects/Comment.dart';
import '../../values/Home_Screen_Fonts.dart';

class SavedArticle extends StatefulWidget {
  const SavedArticle({Key? key}) : super(key: key);

  @override
  State<SavedArticle> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  final _future = DatabaseService().savedArticles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Saved Articles'),
      ),
      body: FutureBuilder<List<ArticlePost>?>(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Center(
                  child: CircularProgressIndicator(),
                )
              ],
            );
          }
          return ArticlesList(
              aritcles: (snapshot.hasData) ? snapshot.data! : []);
        }),
      ),
    );
  }
}
