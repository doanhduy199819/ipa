import 'package:flutter/material.dart';

class TextFuncTionBloc extends StatelessWidget {
  String title;
  TextFuncTionBloc({Key? key , required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        // ignore: prefer_const_constructors
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 11, fontFamily: 'Nunito'),
        ),
      ],
    );
  }
}
