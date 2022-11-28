// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/Question.dart';
import 'package:flutter_interview_preparation/objects/UserData.dart';
import 'package:jiffy/jiffy.dart';

class Helper {
  static String _toFriendlyDurationTime(DateTime date) {
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

  static Widget? handleSnapshot(AsyncSnapshot<dynamic> asyncSnapshot,
      [Widget? waitingWidget]) {
    if (asyncSnapshot.hasError) {
      return Text('Something went wrong :(');
    }
    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      return (waitingWidget == null)
          ? Column(
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            )
          : waitingWidget;
    }
    if (asyncSnapshot == null) {
      return const Icon(Icons.question_mark);
    }
    return null;
  }

  static String toFriendlyDurationTime(DateTime? dateTime) {
    return dateTime?.year == DateTime.now().year
        ? Jiffy(dateTime).MMMd.toString()
        : Jiffy(dateTime).fromNow();
  }

  static void pushTo(context, Widget widget, Object args) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => widget,
        settings: RouteSettings(
          arguments: args,
        ),
      ),
    );
  }
}
