import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../objects/Category.dart';
import '../../values/Quizz_Screen_Fonts.dart';

class QuizCategoryScreen extends StatelessWidget {
  const QuizCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Category category =
        ModalRoute.of(context)!.settings.arguments as Category;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.title!,
          style: QuizzScreenFont.titleAppBar,
        ),
      ),
    );
  }
}