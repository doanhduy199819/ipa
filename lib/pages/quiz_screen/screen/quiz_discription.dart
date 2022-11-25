import 'package:flutter/material.dart';

import '../component/background_quiz_discription.dart';

class QuizDiscription extends StatelessWidget {
  const QuizDiscription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [BackgroundQuizDiscription()],
    );
  }
}
