import 'package:flutter/material.dart';

class ButtonStartQuizWidget extends StatelessWidget {
  const ButtonStartQuizWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18), 
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(165, 204, 255, 1),
            Color.fromRGBO(115, 104, 226, 1)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: const Text(
        "Start Quiz",
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
