import 'package:flutter/material.dart';

import '../../../objects/ExperiencePost.dart';
import '../../../objects/Helper.dart';
import '../../../services/database_service.dart';

class NumberLikesExperiencePost extends StatefulWidget {
  ExperiencePost? experiencePost;
  NumberLikesExperiencePost({Key? key, required this.experiencePost})
      : super(key: key);

  @override
  State<NumberLikesExperiencePost> createState() =>
      _NumberLikesExperiencePostState();
}

class _NumberLikesExperiencePostState extends State<NumberLikesExperiencePost> {
  late Stream<int?> _stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = DatabaseService()
        .getLikeNumExperiencePost(widget.experiencePost?.post_id ?? 'Error');
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
                "${numberOfLikes ?? '0'} like",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
            );
      },
    );
  }
}
