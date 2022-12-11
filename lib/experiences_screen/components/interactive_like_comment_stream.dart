import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/ExperiencePost.dart';

import '../../../objects/Comment.dart';
import '../../../objects/Helper.dart';
import '../../../services/database_service.dart';
import 'interactive_bloc.dart';

class InteractiveLikeStreamBuilder extends StatefulWidget {
  final Comment comment;
  final ExperiencePost experiencePost;
  InteractiveLikeStreamBuilder({
    Key? key,
    required this.comment,
    required this.experiencePost,
  }) : super(key: key);

  @override
  State<InteractiveLikeStreamBuilder> createState() =>
      _InteractiveLikeStreamBuilderState();
}

class _InteractiveLikeStreamBuilderState
    extends State<InteractiveLikeStreamBuilder> {
  late Stream<int?> _stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = DatabaseService().getLikeOfEachCommentInExperiencePost(
        widget.experiencePost.post_id ?? '0', widget.comment.id ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<int?> asyncSnapshot) {
        int? numberOfLikes = asyncSnapshot.data;
        return Helper.handleSnapshot(asyncSnapshot) ??
            Padding(
                padding:
                const EdgeInsets.only(left: 12.0, top: 16.0, bottom: 8.0),
                child: Text(
                  "${numberOfLikes ?? 0}",
                  style: TextStyle(color: Colors.grey.withOpacity(0.5)),
                ));
      },
    );
  }
}
