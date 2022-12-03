// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ArticlePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';
import 'package:flutter_interview_preparation/pages/home_screen/article/articles_list.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

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

