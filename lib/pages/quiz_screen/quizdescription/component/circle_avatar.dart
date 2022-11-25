import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTisLeRl74jRAZXfcxuU9o-trZeAnVbjMKuYw&usqp=CAU'),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
        border: Border.all(width: 1.5, color: Colors.white),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0.0, 5.0),
          ),
        ],
      ),
    );
  }
}
