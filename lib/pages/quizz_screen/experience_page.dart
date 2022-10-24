import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../objects/Experience.dart';
import '../../values/Quizz_Screen_Fonts.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Experience experience =
        ModalRoute.of(context)!.settings.arguments as Experience;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          experience.title!,
          style: QuizzScreenFont.titleAppBar,
        ),
      ),
    );
  }
}