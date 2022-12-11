import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';
import 'package:flutter_interview_preparation/objects/Helper.dart';

import '../../../objects/Comment.dart';
import '../../../services/database_service.dart';

class NumberCommentsOfPost extends StatefulWidget {
  ExperiencePost? experiencePost;

  NumberCommentsOfPost({Key? key, required this.experiencePost}) : super(key: key);

  @override
  State<NumberCommentsOfPost> createState() => _NumberCommentsOfPostState();
}

class _NumberCommentsOfPostState extends State<NumberCommentsOfPost> {
  late Stream<int?> _stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = DatabaseService()
        .getNumberOfComment(widget.experiencePost?.post_id ?? 'Error');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<int?> asyncSnapshot) {
        int? numberOfComments = asyncSnapshot.data;
        return Helper.handleSnapshot(asyncSnapshot) ??
            Padding(
              padding:
              const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
              child: Text(
                "Replies (${numberOfComments ?? '0'})",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
      },
    );
  }
}
