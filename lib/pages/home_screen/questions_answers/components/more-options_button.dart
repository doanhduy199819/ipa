import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_interview_preparation/objects/Comment.dart';
import 'package:flutter_interview_preparation/services/auth_service.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';

class MoreOptionsDropDownButton extends StatelessWidget {
  const MoreOptionsDropDownButton(
      {Key? key, required this.comment, required this.onDelete})
      : super(key: key);

  // List<Widget> childrenNotIncludingCancel;
  final Comment comment;
  final Function() onDelete;
  // final String questionId;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        icon: Visibility(visible: true, child: Icon(Icons.more_horiz_rounded)),
        items: [
          if (comment.author_id == AuthService().currentUserId) ...[
            DropdownMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
          DropdownMenuItem(
            value: 'report',
            child: Text('Report'),
          ),
        ],
        onChanged: ((value) {
          if (value == 'report') {
          } else if (value == 'edit') {
          } else if (value == 'delete') {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Delete?'),
                      content:
                          Text('Are you sure want to delete this comment?'),
                      actions: [
                        FlatButton(
                            onPressed: () {
                              _dissmissAlertDialog(context);
                            },
                            child: Text('No')),
                        FlatButton(
                          onPressed: () {
                            _dissmissAlertDialog(context);
                            onDelete();
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                barrierDismissible: true);
          }
        }),
      ),
    );
  }

  void _dissmissAlertDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
