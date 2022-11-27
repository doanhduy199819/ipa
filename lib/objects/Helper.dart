// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';

class Helper {
  static String toFriendlyDurationTime(DateTime date) {
    DateTime now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes <= 1) {
      return 'A minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 60 && difference.inHours < 2) {
      return 'An hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  Widget? handleSnapshot(AsyncSnapshot<dynamic> asyncSnapshot,
      [bool showCircleLoading = true]) {
    if (asyncSnapshot.hasError) {
      return Text('Something went wrong :(');
    }
    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      return (showCircleLoading)
          ? Column(
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            )
          : SizedBox(
              width: 16.0,
              height: 16.0,
            );
    }
    if (asyncSnapshot == null) {
      return const Icon(Icons.question_mark);
    }
    return null;
  }
}
