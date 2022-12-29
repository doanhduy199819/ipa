import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';

class InteractiveBloc extends StatelessWidget {
  int numberOfComments;
  int numberOfLikes;
  InteractiveBloc(
      {Key? key, required this.numberOfComments, required this.numberOfLikes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.grey.withOpacity(0.6),
              size: 22,
            ),
            const SizedBox(width: 4.0),
            Text(
              "${numberOfLikes} likes",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.6),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.comment,
              color: Colors.grey.withOpacity(0.6),
              size: 16,
            ),
            const SizedBox(width: 4.0),
            Text(
              "${numberOfComments} comment",
              style:
              TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.6)),
            )
          ],
        ),
      ],
    );
  }
}
