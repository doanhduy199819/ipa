import 'package:flutter/material.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 18),
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        onPressed: () {
          // to do back pre page
        },
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.blue,
          size: 13,
        ),
      ),
    );
  }
}
