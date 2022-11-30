import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/values/constants.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({Key? key, this.onFollowActive}) : super(key: key);

  final void Function(bool)? onFollowActive;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFollowing = !isFollowing;
          if (widget.onFollowActive != null) {
            widget.onFollowActive!(isFollowing);
          }
        });
      },
      child: !isFollowing
          ? Container(
              decoration: Constants.BLUE_BACKGROUND_ROUND,
              padding: const EdgeInsets.all(4.0),
              child: const Text(
                'Follow',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          : Container(
              decoration: Constants.GREY_BACKGROUND_ROUND,
              padding: const EdgeInsets.all(4.0),
              child: const Text(
                'Followed',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
            ),
    );
  }
}
