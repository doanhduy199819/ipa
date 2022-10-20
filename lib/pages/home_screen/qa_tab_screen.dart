import 'package:flutter/material.dart';

import '../../values/Home_Screen_Fonts.dart';

class QA extends StatefulWidget {
  const QA({Key? key}) : super(key: key);

  @override
  State<QA> createState() => _QAState();
}


class _QAState extends State<QA> {

  Widget articlePart() {
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8.0, top: 2.0),
            child: Text('Popular articles',
              style: HomeScreenFonts.h1
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),

        ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return articlePart();
  }
}
