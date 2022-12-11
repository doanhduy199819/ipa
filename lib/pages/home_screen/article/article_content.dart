// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/articles_list.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

import '../../../objects/FirestoreUser.dart';

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
    final userData =
    ModalRoute.of(context)!.settings.arguments as FirestoreUser?;
    final _future =
    DatabaseService().getArticlesWithIds(userData?.savedArticles);
    return FutureBuilder<List<ArticlePost>?>(
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
    );
  }

  Future<void> _pullRefresh() async {
    _dataFuture = DatabaseService().allArticlesOnce;
  }
}

