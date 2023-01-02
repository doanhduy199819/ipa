// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/articles_list.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
import 'package:provider/provider.dart';

class SavedArticle extends StatefulWidget {
  const SavedArticle({Key? key}) : super(key: key);

  @override
  State<SavedArticle> createState() => _SavedArticleState();
}

class _SavedArticleState extends State<SavedArticle> {
  @override
  Widget build(BuildContext context) {
    final _future = DatabaseService().savedArticles;

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
              children: const [
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
